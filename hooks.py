"""
MkDocs hooks — post-build sitemap enrichment.
Adds <changefreq> and <priority> per URL pattern.
"""

import os
import re


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

        # MkDocs emits only <loc> and <lastmod>; drop whatever is there and
        # re-add both tags in the order the sitemap schema requires.
        block = re.sub(r"\s*<(changefreq|priority)>[^<]*</\1>", "", block)
        tail = f"\n         <changefreq>{changefreq}</changefreq>\n         <priority>{priority}</priority>"
        anchor = "</lastmod>" if "</lastmod>" in block else "</loc>"
        return block.replace(anchor, anchor + tail, 1)

    content = re.sub(r"<url>.*?</url>", replace_url_block, content, flags=re.DOTALL)

    with open(sitemap_path, "w", encoding="utf-8") as f:
        f.write(content)
