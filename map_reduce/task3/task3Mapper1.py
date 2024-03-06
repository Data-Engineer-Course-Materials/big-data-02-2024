#! /usr/bin/env python3
import sys

for line in sys.stdin:
    key, value = line.strip().split('\t')
    k = value.split(',')
    for i in k:
        print(f'{key},{i}\t*')