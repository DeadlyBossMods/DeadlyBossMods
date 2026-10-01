# DBM-Test Tools

This folder contains tools for generating tests and importing test results.
The test generator can run both as a CLI tool and in WoW.

Requires [`luafilesystem`](https://lunarmodules.github.io/luafilesystem/index.html) when running as a CLI tool

## CreateTest.lua

Turn a Transcriptor log into a test for embedding it directly in DBM.
You do not need to use this for one-off tests, this is just needed to permanently embed a test in DBM.

Usage:

```
lua CreateTest.lua /path/to/log/file
```

The CLI test generator requires Lua >= 5.3 (`string.pack`) and Python 3 for encoding compressed logs. Lua 5.1 and LuaJIT are not supported for this CLI path. In-game test generation uses WoW's `C_EncodingUtil` instead.

TODO: describe other options and `| pbcopy`/`| clip.exe` trick


## ImportTestResults.lua

Extracts test results from saved variables and update golden files in DBM if necessary.


Usage:

```
lua ImportTestResults.lua  --prefix TWW/NerubarPalace /path/to/wow/WTF/Account/<accountname>/SavedVariables/DBM-Test.lua /path/to/reports-dir
```

TODO: describe options

## InfoFrame direct-display regression tests

From the DBM-Retail repository root, run `lua DBM-Test/Tools/CLI/TestInfoFrame.lua`.
This standalone test uses minimal UI mocks and needs no luafilesystem dependency.
Opaque payloads catch conversions and legacy rendering; direct-region text reads and
measurements fail. Actual secret enforcement must also be tested in restricted combat
in WoW, including ancestor hide/show and direct/legacy mode transitions.

### Direct-display API for modules

Open a fresh blank display with `DBM.InfoFrame:ShowDirect(modMaxLines, leftWidth, rightWidth)`.
The count is rows per column; user row/column preferences still apply. Optional widths
are public pixel values; defaults are 12 and 8 times the current font size. Widths never
depend on text contents. Long text may be clipped; provide wider public widths if needed.

While visible, use `SetDirectLine(row, leftText, rightText, ...)` to update an indexed row,
or `UpdateDirect(left1, right1, left2, right2, ...)` to replace all rows in argument order.
Both cells may be secret; nil clears a cell. An odd final argument has a blank right cell.
Indexed rows preserve blank gaps. Empty bulk arguments clear all rows. Optional indexed
colors follow `SetLine`'s convention, but all row, width, count and color controls must be
non-secret. Use `SetDirectHeader(text)` for secret header text; nil clears the header.

These methods return whether the display/update was accepted. Hidden, disabled, wrong-mode
and overflow row updates are discarded; bulk overflow is discarded while visible rows
are accepted. There is no delayed update parameter, automatic refreshing, sorting,
name/icon lookup, class coloring, or invocation of sorting callbacks. Never build a payload
table or schedule secret arguments before calling these methods.

Finish with the shared `Hide()` method. Hiding the frame or an ancestor clears all direct
text; no payload is cached for reopening. Send fresh arguments after showing it again.
Shrinking capacity clears overflow, which is not restored by expanding later. Repeated
`ShowDirect` starts a blank display. `ClearLines`, font/style changes, `SetLines`, `SetColumns`
and strata settings also work in direct mode. Legacy `Update`, `UpdateTable`, `SetLine` and
`SetHeader` do not update direct mode; table-based modes are not secret-safe.
