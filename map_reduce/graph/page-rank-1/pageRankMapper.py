#! /usr/bin/env python3

import sys
import re

for line in sys.stdin:
    print(line.strip().replace('   ', '\t'))
    page_rank = float(line.strip().split('   ')[1])
    out_nodes = line.strip().split('   ')[2]
    list_out_nodes = re.sub("[{}]", "", out_nodes).split(",")
    p = float(round(page_rank / len(list_out_nodes), 3))
    p = "%.3f" % p
    for node in list_out_nodes:
        print(f'{node}\t{p}\t' + "{}")