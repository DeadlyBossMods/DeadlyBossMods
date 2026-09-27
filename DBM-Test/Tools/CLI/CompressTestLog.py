"""Offline companion to TestLogCodec.lua; game code uses C_EncodingUtil instead."""

import base64
import pathlib
import sys
import zlib


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("usage: CompressTestLog.py <CBOR input> <Base64 output>")
    source, target = map(pathlib.Path, sys.argv[1:])
    compressor = zlib.compressobj(level=9, wbits=-15)  # Blizzard method 0 is raw DEFLATE, not zlib.
    data = source.read_bytes()
    compressed = compressor.compress(data) + compressor.flush()
    target.write_text(base64.b64encode(compressed).decode("ascii"), encoding="ascii")


if __name__ == "__main__":
    main()
