"""Crawl every asset URL referenced from index.html (and the CSS files it
links to) and report which ones 404 against the local server.
"""

import re
import urllib.request
from pathlib import Path

EXTRACTED = Path(__file__).parent
SERVER = "http://localhost:8765"
INDEX = EXTRACTED / "index.html"

html = INDEX.read_text(encoding="utf-8", errors="replace")

# All root-relative URLs in the HTML.
urls: set[str] = set()
for m in re.finditer(r'(?:href|src)="(/[^"#?]+)', html):
    urls.add(m.group(1))
for srcset in re.findall(r'srcset="([^"]+)"', html):
    for entry in srcset.split(","):
        first = re.match(r"\s*(\S+)", entry)
        if first and first.group(1).startswith("/"):
            urls.add(first.group(1).split("?")[0])

# Pull every linked CSS file and harvest url(...) refs from each. Resolve
# them against the CSS file's own location so relative urls work.
css_files = re.findall(r'<link[^>]+href="(/[^"]+\.css)[^"]*"', html)
for css_path in css_files:
    css_file = EXTRACTED / css_path.lstrip("/")
    if not css_file.exists():
        continue
    css = css_file.read_text(encoding="utf-8", errors="replace")
    for m in re.finditer(r'url\(["\']?([^"\')]+)["\']?\)', css):
        ref = m.group(1).strip()
        if ref.startswith("data:"):
            continue
        if ref.startswith("/"):
            urls.add(ref.split("?")[0])
        elif not ref.startswith("http"):
            base = css_file.parent
            resolved = (base / ref).resolve()
            try:
                rel = resolved.relative_to(EXTRACTED)
                urls.add("/" + str(rel).split("?")[0])
            except ValueError:
                pass


def status(u: str) -> int:
    try:
        req = urllib.request.Request(SERVER + u, method="HEAD")
        with urllib.request.urlopen(req, timeout=3) as r:
            return r.status
    except urllib.error.HTTPError as e:
        return e.code
    except Exception:
        return 0


broken = []
for u in sorted(urls):
    code = status(u)
    if code != 200:
        broken.append((code, u))

print(f"checked {len(urls)} URLs, broken {len(broken)}")
by_kind: dict[str, list[str]] = {}
for code, u in broken:
    ext = u.rsplit(".", 1)[-1].lower() if "." in u.rsplit("/", 1)[-1] else "(no-ext)"
    by_kind.setdefault(ext, []).append(f"{code}  {u}")

for ext in sorted(by_kind):
    print(f"\n--- .{ext} ({len(by_kind[ext])}) ---")
    for line in by_kind[ext][:80]:
        print(line)
