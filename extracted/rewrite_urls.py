"""Make a copy of www.thinkific.com/index.html with absolute URLs remapped to
local paths so the saved page renders against the locally extracted assets.

Only URL *prefixes* are rewritten: https://example.com/path -> /example.com/path
The HTML structure, CSS, classes, and content are untouched.
"""

import re
from pathlib import Path

ROOT = Path(__file__).parent
SRC = ROOT / "www.thinkific.com" / "index.html"
DST = ROOT / "index.html"

# Folders that exist in extracted/ are valid local mirrors of those domains.
domains = sorted(
    [p.name for p in ROOT.iterdir() if p.is_dir() and "." in p.name],
    key=len,
    reverse=True,  # longer first so subdomains win over shorter matches
)

html = SRC.read_text(encoding="utf-8", errors="replace")

# Step 1: protect root-relative paths (these refer to the thinkific.com site).
# Use a sentinel token so subsequent regexes don't double-process them.
SENTINEL = "\x00THINKIFIC_ROOT\x00"
html = re.sub(r'(href|src|action)="/(?!/)', rf'\1="{SENTINEL}', html)

# Step 2: rewrite absolute URLs (https://, http://, //) to /domain/ form.
for d in domains:
    html = re.sub(rf"https?://{re.escape(d)}/", f"/{d}/", html)
    html = re.sub(rf'(?<=["\'(\s])//{re.escape(d)}/', f"/{d}/", html)

# Step 3: replace the sentinel with the thinkific.com folder prefix.
html = html.replace(SENTINEL, "/www.thinkific.com/")

DST.write_text(html, encoding="utf-8")
print(f"wrote {DST} ({DST.stat().st_size:,} bytes)")
