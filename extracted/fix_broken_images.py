"""Find broken image references in extracted/index.html and try to fix them
using files the user uploaded to the project root.

Strategy:
- Parse all <img src=...> and srcset URLs (and <source> srcset) from index.html.
- Filter to root-relative paths under /www.thinkific.com/wp-content/uploads/.
- For each path, check whether the file exists on disk under extracted/.
- For each missing path, try to find a matching uploaded file in PROJECT_ROOT
  by basename (with stem-based fuzzy fallback so .webp uploads match .png paths
  and so size-suffixed variants get filled from the closest sibling).
- Copy matched bytes into the expected path so the local server returns 200.
- Report what was fixed and what is still missing.
"""

import re
import shutil
from pathlib import Path

EXTRACTED = Path(__file__).parent
PROJECT_ROOT = EXTRACTED.parent
INDEX = EXTRACTED / "index.html"

html = INDEX.read_text(encoding="utf-8", errors="replace")

# Collect every URL that lives under /www.thinkific.com/wp-content/uploads/.
url_pattern = re.compile(
    r'(/www\.thinkific\.com/wp-content/uploads/[^\s"\'<>?]+)'
)
urls = set(url_pattern.findall(html))

# Also harvest srcset entries (comma-separated "url width" pairs).
for srcset in re.findall(r'srcset="([^"]+)"', html):
    for entry in srcset.split(","):
        m = re.match(r"\s*(\S+)", entry)
        if m and m.group(1).startswith("/www.thinkific.com/wp-content/uploads/"):
            urls.add(m.group(1))

missing = []
for u in sorted(urls):
    rel = u.lstrip("/")
    p = EXTRACTED / rel
    if not p.exists():
        missing.append((u, p))

print(f"total upload URLs referenced: {len(urls)}")
print(f"missing on disk: {len(missing)}")

# Build a lookup of uploaded files in PROJECT_ROOT (not extracted/).
uploads = [
    p for p in PROJECT_ROOT.iterdir()
    if p.is_file()
    and p.suffix.lower() in {".png", ".jpg", ".jpeg", ".webp", ".gif", ".svg"}
]
by_name = {p.name: p for p in uploads}
by_stem = {p.stem: p for p in uploads}


def stem_no_size(stem: str) -> str:
    """Strip a trailing -WIDTHxHEIGHT suffix (e.g. -768x884) from a stem."""
    return re.sub(r"-\d+x\d+$", "", stem)


by_base_stem: dict[str, list[Path]] = {}
for p in uploads:
    by_base_stem.setdefault(stem_no_size(p.stem), []).append(p)


def find_match(target_path: Path) -> Path | None:
    target_name = target_path.name
    target_stem = target_path.stem

    if target_name in by_name:
        return by_name[target_name]

    # Same stem, different extension (.png path -> .webp upload)
    if target_stem in by_stem:
        return by_stem[target_stem]

    # Strip size suffix on the target and look for any sibling with the same base.
    base = stem_no_size(target_stem)
    if base in by_base_stem:
        # Prefer the upload whose stem also lacks a size suffix (the "original"),
        # otherwise just take the largest by file size.
        candidates = by_base_stem[base]
        no_size = [c for c in candidates if stem_no_size(c.stem) == c.stem]
        if no_size:
            return no_size[0]
        return max(candidates, key=lambda p: p.stat().st_size)

    return None


fixed = []
still_missing = []
for url, target in missing:
    match = find_match(target)
    if match is None:
        still_missing.append(url)
        continue
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(match, target)
    fixed.append((url, match.name))

print(f"\nFixed ({len(fixed)}):")
for u, src in fixed:
    print(f"  {u}  <-  {src}")

print(f"\nStill missing ({len(still_missing)}):")
for u in still_missing:
    print(f"  {u}")
