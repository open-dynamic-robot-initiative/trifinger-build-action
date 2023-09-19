#!/usr/bin/env python3
"""Find path to a given Python package."""
import argparse
import importlib.util
import os
import sys


def _main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("package_name", type=str, help="Name of the package.")
    args = parser.parse_args()

    pkg_spec = importlib.util.find_spec(args.package_name)

    if pkg_spec is None:
        print(f"Package {args.package_name} not found", file=sys.stderr)
    else:
        print(os.path.dirname(pkg_spec.origin))

    return 0


if __name__ == "__main__":
    sys.exit(_main())
