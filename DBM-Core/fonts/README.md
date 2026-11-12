# Binary debug capture font

The debug log (`/dbm debug`, then `/dbm dlog`) uses its usual human-readable font
by default. **Binary capture font** switches only the capture panel; clicking
**Human-readable font** restores it. The choice is saved in `DebugLogBinaryFont`.
It does not change logging, callbacks, event registrations, or stored text.
On first enable, DBM registers the file through a native `Font` object before
applying it to the capture FontStrings. This load sequence was confirmed on
Forever/macOS; it does not read any displayed text. The object is reused on
later toggles and scale changes.

Both font modes preserve the panel's size. Binary mode adds a binary page header.
Switching back explicitly restores the human font's file, size, and flags as
well as its Font object; this reads only font configuration, not displayed text.
Capture the **entire panel**, including the header and both ends of every line.
Keep screenshots at their original resolution, preferably PNG. The usual page
buttons still advance by fully visible rows, with a bottom safety row.

## Encoding (v1)

`DBMBinary.ttf` is an original geometric TrueType font. No source font or copied
letter outlines are used. It is distributed under the project's license.
The font explicitly declares its Windows Latin code page, regular style, and
unrestricted embedding metadata. Client acceptance must still be verified;
successful FreeType/CoreText loading alone does not establish WoW compatibility.

Each printable ASCII character (32 through 126, including space) has:

- Seven data bits, preserving case, digits, and punctuation.
- Four Hamming check bits and an overall parity bit (12 cells total).
- A solid vertical locator bar, separate from the data cells.

In cell units, the locator occupies `x=0..1, y=0..7`. Data cells are at columns
`x=2,4,6` and rows `y=6,4,2,0` (top to bottom). The character advance is 8;
the em size is 12. Data positions in the Hamming word are 3,5,6,7,9,10,11,
least-significant ASCII bit first. Check positions are 1,2,4,8; position 12
provides even overall parity. Cells are solid or empty, not text shapes.

Every rendered row has public `~DBM1~` / `~END~` framing. A separate public header
contains `#DBMP1:<visible-row-count>`, with the same framing. The decoder verifies
the framing, parity, three threshold results, and page row count. It rejects
errors rather than guessing or silently running English OCR on a detected
damaged binary page. Parity is not a cryptographic checksum and cannot detect
every possible multi-cell corruption.

Lua does not encode, split, inspect, or calculate checksums over secret text:
the native font renderer maps characters to glyphs. Existing native color markup
remains in effect. Non-ASCII names, embedded textures, and other non-font content
are **not supported** by this version; use ordinary text captures for these.

## Decoder and verification

The workspace's `Agent Tools/ocr_logs.py` supports ordinary text, binary, and
mixed screenshot folders. For a known binary folder use
`--capture-format binary`; unlike auto detection, this also rejects pages with
no recognizable binary glyphs. `--capture-format text` explicitly retains the
original English/Tesseract path. Existing reviewed caches are still preserved.

Raster tests cover all printable ASCII at 12/24/36/48 pixel font sizes, native
debug colors, PNG/JPEG, corruption, clipping, page counts, and mixed English OCR.
Row detection tolerates a one-pixel locator-edge difference across colored spans
while retaining shared data-cell geometry and all three threshold/parity checks.
One Forever/macOS capture with white framing and cyan text has passed these
checks; this is not broad in-game capture validation.
Fractional pixel sizing/resampling can fail; capture without resizing. Binary
mode compensates for the frame's effective UI scale to target a 12-pixel font
and adjusts row spacing/pagination accordingly. Render scaling and the native
font backend still need verification on the capture client.
Cells need sufficient physical pixels; a successful desktop test does not
certify WoW's renderer or secret-value handling. In-game verification is required
before relying on this experimental capture method. No near-100% accuracy claim
is made.

The font is reproducibly generated from the workspace tool:

```sh
.venv/bin/python "Agent Tools/dbm_binary_font.py" \
  --build-font "DBM-Retail/DBM-Core/fonts/DBMBinary.ttf"
.venv/bin/python "Agent Tools/test_dbm_binary_font.py"
```

Decoding requires Pillow; regeneration additionally requires fontTools. These
are developer dependencies, not addon runtime dependencies.
