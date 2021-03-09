#!/usr/bin/env python3

import json
import shutil
import sys
import os

JSON_FILE = "metadata.json"
STORE = "data"
HOME = os.path.expanduser("~")


def copy(entry, srcRoot, dstRoot):
    src = os.path.join(srcRoot, entry)
    dst = os.path.join(dstRoot, entry)

    if not os.path.exists(src):
        print("SKIPPED: " + src)
    else:
        try:
            # Clean target
            if os.path.isfile(dst):
                os.remove(dst)
            elif os.path.isdir(dst):
                shutil.rmtree(dst)

            # Ensure parent directory for target
            if os.path.isfile(src):
                dstDir = os.path.dirname(dst)
                if not os.path.exists(dstDir):
                    os.makedirs(dstDir)
            elif os.path.isdir(src):
                dstDir = os.path.dirname(os.path.dirname(dst))
                if not os.path.exists(dstDir):
                    os.makedirs(dstDir)

            # Copy target
            if os.path.isfile(src):
                shutil.copy2(src, dst)
            elif os.path.isdir(src):
                shutil.copytree(src, dst)
            print("OK: " + src + " -> " + dst)
        except Exception as e:
            print("FAILED: " + src + " ->", e)


def backup(data):
    for entry in data:
        copy(entry, HOME, STORE)


def restore(data):
    for entry in data:
        copy(entry, STORE, HOME)


if __name__ == '__main__':
    with open(JSON_FILE) as jsonFile:
        data = json.load(jsonFile)

    if len(sys.argv) == 1:
        print("backup|restore")
    elif sys.argv[1] == "backup":
        backup(data)
    elif sys.argv[1] == "restore":
        restore(data)
    else:
        print("Invalid command")
