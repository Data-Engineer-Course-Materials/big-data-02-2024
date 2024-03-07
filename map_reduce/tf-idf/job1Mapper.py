#! /usr/bin/env python3

import sys
import re

for line in sys.stdin:
    items = line.strip().split(':')
    docname = items[0]
    content = re.sub(f'[^a-zA-Z0-9]', ' ', items[1])
    words =content.strip().split(' ')
    for i in range(len(words)):
        if words[i] != '':
            print(f'{words[i]}#{docname}\t1')