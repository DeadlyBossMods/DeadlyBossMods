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

This tool should work with any Lua version >= 5.1 (including LuaJIT), but is mainly tested with Lua 5.1 as it is also used in WoW.

TODO: describe other options and `| pbcopy`/`| clip.exe` trick


## ImportTestResults.lua

Extracts test results from saved variables and update golden files in DBM if necessary.


Usage:

```
lua ImportTestResults.lua  --prefix TWW/NerubarPalace /path/to/wow/WTF/Account/<accountname>/SavedVariables/DBM-Test.lua /path/to/reports-dir
```

TODO: describe options
