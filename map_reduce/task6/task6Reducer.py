#! /usr/bin/env python3

import sys

a, b = [],[]

for line in sys.stdin:
    user_id, value = line.strip().split('\t')
    if 'query' in value:
        a.append(f'{user_id}:{value.partition(":")[2]}')
    else:
        b.append(f'{user_id}:{value.partition(":")[2]}')

for i in a:
    for j in b:
        if i.partition(':')[0] == j.partition(':')[0]:
            print(f'{i.partition(":")[0]}\t{i.partition(":")[2]}\t{j.partition(":")[2]}')