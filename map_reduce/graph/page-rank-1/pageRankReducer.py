#! /usr/bin/env python3

import sys
import re

N = 5
ALFA = 0.1

prev_node = ''
prev_adjacency = '{}'
sum_weight = 0

for line in sys.stdin:
    v_input, weight, adjustment_string = line.strip().split('\t')
    if not prev_node:
        if adjustment_string == '{}':
            sum_weight += float(weight)
        else:
            prev_adjacency = adjustment_string
    elif v_input == prev_node:
        if adjustment_string == '{}':
            sum_weight += float(weight)
        else:
            prev_adjacency = adjustment_string
    else:
        if prev_adjacency == '{}':
            page_rank = ALFA / N
        else:
            page_rank = ALFA / N + (1-ALFA)*sum_weight
        print('%s\t%.3f\t%s' % (prev_node, page_rank, prev_adjacency))

        if adjustment_string == '{}':
            sum_weight = float(weight)
        else:
            sum_weight = 0
            prev_adjacency = adjustment_string

    prev_node  = v_input

if prev_adjacency == '{}':
    page_rank = ALFA / N
else:
    page_rank = ALFA / N + (1 - ALFA) * sum_weight
print('%s\t%.3f\t%s' % (prev_node, page_rank, prev_adjacency))