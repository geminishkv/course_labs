"""
MkDocs hooks — post-build sitemap enrichment.
Adds <priority> and corrects <changefreq> per URL pattern.
"""

import os
import re


# ─── Priority / changefreq rules ───────────────────────────────────────────────
# Evaluated top-to-bottom; first match wins.
_RULES = [
    # Homepage
    (r"^/$",                          "1.0", "weekly"),
    # Lab pages
    (r"^/labs/",                      "0.8", "weekly"),
    (r"^/labs/pet_project",           "0.7", "monthly"),
    # Tests
    (r"^/tests/",                     "0.5", "monthly"),
    # OWASP materials
    (r"^/materials/OWASPTOP10/",      "0.7", "monthly"),
    # Examples
    (r"^/materials/examples/",        "0.6", "monthly"),
    # Cheatsheets
    (r"^/artifacts/cheatsheet/",      "0.7", "monthly"),
    # Reference pages
    (r"^/appsec_tt/",                 "0.7", "monthly"),
    (r"^/licenses/",                  "0.6", "monthly"),
    (r"^/APPENDIX/",                  "0.6", "monthly"),
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


def on_post_build(config, **kwargs):
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

        # Replace <changefreq> if present, add <priority>
        block = re.sub(r"<changefreq>[^<]*</changefreq>",
                       f"<changefreq>{changefreq}</changefreq>", block)
        # Insert <priority> after <lastmod> or <changefreq>
        if "<priority>" not in block:
            block = re.sub(
                r"(</lastmod>|</changefreq>)",
                r"\1\n         <priority>" + priority + r"</priority>",
                block,
                count=1,
            )
        return block

    content = re.sub(r"<url>.*?</url>", replace_url_block, content, flags=re.DOTALL)

    with open(sitemap_path, "w", encoding="utf-8") as f:
        f.write(content)
