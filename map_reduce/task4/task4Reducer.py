#! /usr/bin/env python3
import sys

result = {}

for line in sys.stdin:
    key, value = line.strip().split('\t')
    H = dict((a.strip(), int(b.strip()))
        for a,b in (element.split(':')
            for element in value.split(',')))
    for k, v in H.items():
        old_value = result.get((key, k))
        if old_value is None:
            sum_result = int(v)
        else:
            sum_result = old_value + v
        result.update({(key, k): sum_result})

for key,value in result.items():
    print(f'{key}\t{value}')