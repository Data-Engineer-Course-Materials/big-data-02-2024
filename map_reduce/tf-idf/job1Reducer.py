#! /usr/bin/env python3

import sys

doc_all_count = {}
doc_word_count ={}

for line in sys.stdin:
    pair, count = line.strip().split('\t')
    word, docname = pair.strip().split('#')
    old_value = doc_word_count.get(pair)
    if old_value is None:
        sum = int(count)
    else:
        sum = int(old_value)+int(count)
    doc_word_count.update({pair: sum})
    old_value = doc_all_count.get(docname)
    if old_value is None:
        sum = int(count)
    else:
        sum = int(old_value)+int(count)
    doc_all_count.update({docname: sum})

for key, value in doc_word_count.items():
    word, docname = key.strip().split('#')
    sum_nj = int(doc_all_count.get(docname))-int(value)
    tf = int(value)/sum_nj
    print(f'{word}#{docname}\t{tf}')