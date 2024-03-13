import pyarrow as pa
from pyarrow import orc
import pandas as pd

table = pa.table({
    'one': [1,2,3],
    'two': [1.5, 2.5, 3.5],
    'three': [True, False, False],
    'four': ['one', 'two', 'three']
})

orc.write_table(table, 'sample.orc')

table = orc.read_table('sample.orc', columns=['one', 'two', 'three'])
df = table.to_pandas()
print(df.head())