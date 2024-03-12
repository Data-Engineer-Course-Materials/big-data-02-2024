import avro.schema
from avro.datafile import DataFileWriter, DataFileReader
from avro.io import DatumWriter, DatumReader

file_schema = avro.schema.parse(open("sample.avsc", "r").read())
print(file_schema)

employee = {
    "customer_id": 12,
    "customer_name": "Andrey",
    "joining_date": 20240312,
    "salary": 123.55,
    "address": "test address",
    "update_date": 20240312010101
}

writer = DataFileWriter(open("sample.avro", "wb"), DatumWriter(), file_schema)
writer.append(employee)
writer.close()