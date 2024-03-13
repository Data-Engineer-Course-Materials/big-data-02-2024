#! /usr/bin/env python3

import sys

dict_graph = {}

for line in sys.stdin:
    v_input, weight, adjustment_string = line.strip().split()
    adjustment_list = adjustment_string[1:-1].strip().split(',')

    if weight.strip() == 'INF':
        weight = float('inf')
    else:
        weight = int(weight)

    value = {}
    value.update({'weight': weight})
    value.update({'adjustment_list': adjustment_list})

    if v_input not in dict_graph:
        dict_graph[v_input] = value
    else:
        if weight < dict_graph[v_input]['weight']:
            dict_graph[v_input]['weight'] = weight
        dict_graph[v_input]['adjustment_list'].extend(adjustment_list)

for key in dict_graph:
    adjustment_list_result = []
    for node in dict_graph[key]['adjustment_list']:
        if node != '':
            adjustment_list_result.append(node)
    weight = str(dict_graph[key]['weight']).upper()
    print(f"{key}\t{weight}\t" + '{' + ','.join(adjustment_list_result) + '}')