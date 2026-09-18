"""Учебный сервис лабораторной docker02: переводит доменное имя в punycode."""

import sys

import idna


def main() -> int:
    name = sys.argv[1] if len(sys.argv) > 1 else "пример.рф"
    print(idna.encode(name).decode("ascii"))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
