#! /usr/bin/env python3
import sys

result = []

for line in sys.stdin:
    key, value = line.strip().split('\t')
    if key not in result:
        result.append(key)

for key in result:
    print(key)