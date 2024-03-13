#! /usr/bin/env python3

import sys

doc_word_count = {}

for line in sys.stdin:
    pair, pair2 = line.strip().split('\t')
    word, docname = pair.strip().split('#')
    tf, count = pair.strip().split(':')
    old_value = doc_word_count.get(word)
    if old_value is None:
        sum = int(count)
    else:
        sum = int(old_value)+int(count)
    doc_word_count.update({pair: [sum]})

for key, value in doc_word_count.items():
    value = doc_word_count.get(key)
    print(f'{word}#{docname}\t{tf}:{value}')