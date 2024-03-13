#! /usr/bin/env python3

import sys

for line in sys.stdin:
    if '\tadmin\t' in line:
        user_id, login, url = line.strip().split('\t')
        print(url)