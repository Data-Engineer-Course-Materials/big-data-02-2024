#! /usr/bin/env python3

import sys

for line in sys.stdin:
    print(line.strip())
    v_input, weight, adjustment_string = line.strip().split()
    adjustment_list = adjustment_string[1:-1].strip().split(',')
    if adjustment_list != ['']:
        for node in adjustment_list:
            node_weight = weight if weight == 'INF' else str(int(weight)+1)
            print(f'{node}\t{node_weight}\t' + '{}')