"""
MkDocs hooks.

- on_page_markdown: fills the `{{ stats.* }}` placeholders on the home page
  with figures counted from the docs tree (labs, guides, tests, materials by
  type, diagrams, FAQ cards) in the right Russian plural form, so the home page
  never goes stale by hand.
- on_post_build: sitemap enrichment — <changefreq> and <priority> per URL
  pattern — and redirect stubs for pages that have moved.
"""

import glob
import logging
import os
import re

log = logging.getLogger("mkdocs.hooks.tplabworks")

# ─── Home page figures ─────────────────────────────────────────────────────────
_STATS_TOKEN = re.compile(r"\{\{\s*stats\.(\w+)\s*\}\}")


def _plural(n: int, one: str, few: str, many: str) -> str:
    """Russian plural form for a count: 1 материал, 2 материала, 5 материалов."""
    if n % 10 == 1 and n % 100 != 11:
        return one
    if 2 <= n % 10 <= 4 and not 12 <= n % 100 <= 14:
        return few
    return many


# word forms for the figures shown on the home page: (one, few, many)
_WORDS = {
    "labs": ("лабораторная", "лабораторные", "лабораторных"),
    "advanced": ("работа", "работы", "работ"),
    "intro": ("руководство", "руководства", "руководств"),
    "tests": ("тест", "теста", "тестов"),
    "materials": ("материал", "материала", "материалов"),
    "diagrams": ("схема", "схемы", "схем"),
    "trouble_cards": ("решение", "решения", "решений"),
    "cheatsheets": ("шпаргалка", "шпаргалки", "шпаргалок"),
    "references": ("справочник", "справочника", "справочников"),
    "owasp": ("разбор", "разбора", "разборов"),
    "cases": ("кейс", "кейса", "кейсов"),
    "lectures": ("лекция", "лекции", "лекций"),
    "tests_lectures": ("вариант", "варианта", "вариантов"),
}


def _count_docs(docs_dir: str) -> dict[str, int | str]:
    def paths(pattern: str, base: str = docs_dir) -> list[str]:
        return glob.glob(os.path.join(base, pattern), recursive=True)

    def count(pattern: str, exclude: tuple[str, ...] = ()) -> int:
        return len([p for p in paths(pattern) if os.path.basename(p) not in exclude])

    def read(path: str) -> str:
        with open(path, encoding="utf-8") as f:
            return f.read()

    # lab and guide sources live next to docs/ and are pulled in by include-markdown
    labs_dir = os.path.join(docs_dir, os.pardir, "labs")
    sources = paths("**/*.md") + paths("**/*.md", labs_dir)
    trouble = read(os.path.join(docs_dir, "materials", "troubleshooting.md"))
    topics = [part for part in re.split(r"(?m)^## ", trouble)[1:] if 'class="lab-card"' in part]

    stats: dict[str, int | str] = {
        "labs": count("labs/basic/lab*.md"),
        # the optional Docker track; its landing page is not a lab
        "advanced": count("labs/advanced/docker*.md"),
        "intro": count("materials/guides/*.md"),
        "tests": count("labs/tests/**/*.md"),
        "tests_basic": count("labs/tests/basic/*.md"),
        "tests_lectures": count("labs/tests/lectures/*.md"),
        # guides are counted as "intro", not twice
        "materials": count("materials/**/*.md", exclude=("index.md",)) - count("materials/guides/*.md"),
        "cheatsheets": count("materials/cheatsheet/*.md"),
        # reference pages sit in the materials root, next to the index and the FAQ
        "references": count("materials/*.md", exclude=("index.md", "troubleshooting.md")),
        "owasp": count("materials/OWASPTOP10/*.md"),
        "cases": count("materials/examples/*.md"),
        "lectures": count("materials/lectures/*.md"),
        "trouble_cards": trouble.count('class="lab-card"'),
        "trouble_topics": len(topics),
        "diagrams": sum(read(p).count("```mermaid") for p in sources),
    }
    # "<name>_word" is the noun in the right form, "<name>_label" is "N noun"
    for name, forms in _WORDS.items():
        word = _plural(int(stats[name]), *forms)
        stats[f"{name}_word"] = word
        stats[f"{name}_label"] = f"{stats[name]} {word}"
    return stats


def on_page_markdown(markdown, page, config, files):
    if page.file.src_uri != "index.md":
        return markdown
    stats = _count_docs(config["docs_dir"])

    def _fill(match):
        name = match.group(1)
        if name not in stats:
            # a warning fails `mkdocs build --strict`: a raw token never ships
            log.warning("index.md: unknown home page token stats.%s", name)
            return match.group(0)
        return str(stats[name])

    return _STATS_TOKEN.sub(_fill, markdown)


# ─── Priority / changefreq rules ───────────────────────────────────────────────
# Evaluated top-to-bottom; first match wins, so specific paths go before their prefix.
_RULES = [
    # Homepage
    (r"^/$",                          "1.0", "weekly"),
    # Tests and pet project (under /labs/, so they must precede the generic rule)
    (r"^/labs/tests/",                "0.5", "monthly"),
    (r"^/labs/pet_project",           "0.7", "monthly"),
    # Lab pages
    (r"^/labs/",                      "0.8", "weekly"),
    # Guides (the former /labs/intro/ pages keep their weight)
    (r"^/materials/guides/",          "0.8", "weekly"),
    # OWASP materials
    (r"^/materials/OWASPTOP10/",      "0.7", "monthly"),
    # Examples
    (r"^/materials/examples/",        "0.6", "monthly"),
    # Cheatsheets
    (r"^/materials/cheatsheet/",      "0.7", "monthly"),
    # Reference pages
    (r"^/materials/appsec_tt/",       "0.7", "monthly"),
    (r"^/materials/licenses/",        "0.6", "monthly"),
    (r"^/materials/APPENDIX/",        "0.6", "monthly"),
    (r"^/materials/troubleshooting/", "0.6", "monthly"),
    (r"^/materials/ports/",           "0.6", "monthly"),
    (r"^/materials/risk_scoring/",    "0.7", "monthly"),
    (r"^/materials/findings_triage/", "0.7", "monthly"),
    (r"^/materials/diagrams_legend/", "0.6", "monthly"),
    # About / meta
    (r"^/about/",                     "0.5", "monthly"),
    (r"^/RELEASE_NOTES/",             "0.6", "monthly"),
    (r"^/Security/",                  "0.4", "yearly"),
    # Fallback
    (r".*",                           "0.5", "monthly"),
]


def _get_rule(path: str) -> tuple[str, str]:
    for pattern, priority, changefreq in _RULES:
        if re.search(pattern, path):
            return priority, changefreq
    return "0.5", "monthly"


# ─── Moved pages ───────────────────────────────────────────────────────────────
# Old URL -> new URL, both relative to the site root. The old addresses are
# indexed and bookmarked, so each gets a stub that forwards to the new page.
# Done here instead of mkdocs-redirects: since 1.2.3 that plugin belongs to
# another project and pulls in a second documentation framework.
_GUIDES = ("vmbox_tutorial", "git_setup", "gistup_guide", "networking_basics",
           "docker_basics", "cicd_basics", "appsec_tools_setup")
_REDIRECTS = {f"labs/intro/{name}/": f"materials/guides/{name}/" for name in _GUIDES}

_REDIRECT_PAGE = """<!doctype html>
<html lang="ru">
<head>
<meta charset="utf-8">
<title>Страница переехала</title>
<link rel="canonical" href="{canonical}">
<meta name="robots" content="noindex">
<meta http-equiv="refresh" content="0; url={target}">
</head>
<body>
<p>Страница переехала: <a href="{target}">{canonical}</a></p>
</body>
</html>
"""


def _write_redirects(config) -> None:
    site_url = config.get("site_url", "").rstrip("/")
    for old, new in _REDIRECTS.items():
        depth = old.strip("/").count("/") + 1
        target = "../" * depth + new
        path = os.path.join(config["site_dir"], old, "index.html")
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w", encoding="utf-8") as f:
            f.write(_REDIRECT_PAGE.format(target=target, canonical=f"{site_url}/{new}"))


def on_post_build(config, **kwargs):
    _write_redirects(config)

    sitemap_path = os.path.join(config["site_dir"], "sitemap.xml")
    if not os.path.exists(sitemap_path):
        return

    site_url = config.get("site_url", "").rstrip("/")

    with open(sitemap_path, "r", encoding="utf-8") as f:
        content = f.read()

    def replace_url_block(match):
        block = match.group(0)
        # Extract <loc>
        loc_match = re.search(r"<loc>(.*?)</loc>", block)
        if not loc_match:
            return block
        loc = loc_match.group(1)
        # Derive path
        path = loc.replace(site_url, "") or "/"
        if not path.startswith("/"):
            path = "/" + path

        priority, changefreq = _get_rule(path)

        # MkDocs emits only <loc> and <lastmod>; drop whatever is there and
        # re-add both tags in the order the sitemap schema requires.
        block = re.sub(r"\s*<(changefreq|priority)>[^<]*</\1>", "", block)
        tail = f"\n         <changefreq>{changefreq}</changefreq>\n         <priority>{priority}</priority>"
        anchor = "</lastmod>" if "</lastmod>" in block else "</loc>"
        return block.replace(anchor, anchor + tail, 1)

    content = re.sub(r"<url>.*?</url>", replace_url_block, content, flags=re.DOTALL)

    with open(sitemap_path, "w", encoding="utf-8") as f:
        f.write(content)
