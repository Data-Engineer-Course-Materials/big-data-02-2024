#! /usr/bin/env python3
import sys
from collections import defaultdict

def stripe_to_str(source):
    result = []
    for element in source:
        result.append(element+':'+str(source[element]))
    return ','.join(result)


for line in sys.stdin:
    items = line.strip().split(' ')
    for i in items:
        stripe = defaultdict(int)
        for j in items:
            if i != j:
                stripe[j] += 1
        print(f'{i}\t{stripe_to_str(stripe)}')