"""For every image URL referenced by index.html that's missing on disk, look
for a sibling file in the same directory whose name shares the same base stem
(after stripping any -WIDTHxHEIGHT suffix). If found, copy that sibling's
bytes to the missing path so the browser's srcset request resolves to a 200.
"""

import re
import shutil
from pathlib import Path

EXTRACTED = Path(__file__).parent
INDEX = EXTRACTED / "index.html"

html = INDEX.read_text(encoding="utf-8", errors="replace")

url_pattern = re.compile(
    r'(/www\.thinkific\.com/wp-content/uploads/[^\s"\'<>?]+)'
)
urls = set(url_pattern.findall(html))
for srcset in re.findall(r'srcset="([^"]+)"', html):
    for entry in srcset.split(","):
        m = re.match(r"\s*(\S+)", entry)
        if m and m.group(1).startswith("/www.thinkific.com/wp-content/uploads/"):
            urls.add(m.group(1))


def stem_no_size(stem: str) -> str:
    return re.sub(r"-\d+x\d+$", "", stem)


fixed = []
still_missing = []

for url in sorted(urls):
    target = EXTRACTED / url.lstrip("/")
    if target.exists():
        continue

    base = stem_no_size(target.stem)
    siblings = [
        p for p in target.parent.glob("*")
        if p.is_file() and stem_no_size(p.stem) == base and p != target
    ]
    if not siblings:
        still_missing.append(url)
        continue

    # Prefer a sibling whose stem itself has no size suffix (the "original");
    # otherwise the largest by file size.
    no_size = [s for s in siblings if stem_no_size(s.stem) == s.stem]
    src = no_size[0] if no_size else max(siblings, key=lambda p: p.stat().st_size)

    shutil.copyfile(src, target)
    fixed.append((url, src.name))

print(f"Filled {len(fixed)} variants from on-disk siblings:")
for u, src in fixed:
    print(f"  {u}  <-  {src}")

print(f"\nStill missing ({len(still_missing)}):")
for u in still_missing:
    print(f"  {u}")
