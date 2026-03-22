from __future__ import annotations

import datetime
import os
import urllib.parse
from xml.etree.ElementTree import Element, ElementTree, SubElement

BASE_URL = "https://course.geminishkv.tech"


def main() -> None:
    urlset = Element(
        "urlset",
        xmlns="http://www.sitemaps.org/schemas/sitemap/0.9",
    )
    today = datetime.date.today().isoformat()

    for root, _, files in os.walk("site"):
        for name in files:
            if not name.endswith(".html"):
                continue

            rel_path = os.path.relpath(os.path.join(root, name), "site")
            if rel_path in ("search.html", "404.html"):
                continue

            if rel_path == "index.html":
                loc = BASE_URL + "/"
            else:
                loc = (
                    BASE_URL
                    + "/"
                    + urllib.parse.quote(
                        rel_path.replace("index.html", "").rstrip("/"),
                    )
                )

            url = SubElement(urlset, "url")
            SubElement(url, "loc").text = loc
            SubElement(url, "lastmod").text = today
            SubElement(url, "changefreq").text = "weekly"

    tree = ElementTree(urlset)
    tree.write("site/sitemap.xml", encoding="utf-8", xml_declaration=True)


if __name__ == "__main__":
    main()
