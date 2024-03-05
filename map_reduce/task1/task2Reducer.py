#! /usr/bin/env python3
import sys

max_value = 0
max_year = None
max_month = None
min_value = 1000
min_year = None
min_month = None

for line in sys.stdin:
    year, value = line.strip().split('\t')
    count, month = value.strip().split(',')
    count = int(count)

    if max_value < count:
        max_value = count
        max_year = year
        max_month = month

    if min_value > count:
        min_value = count
        min_year = year
        min_month = month

print(str(max_year) + '\t' + str(max_month) + '\t' + str(max_value))
print(str(min_year) + '\t' + str(min_month) + '\t' + str(min_value))