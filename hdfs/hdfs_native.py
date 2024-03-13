from pyarrow import fs

hadoop_fs = fs.HadoopFileSystem('hdfs://0.0.0.0:9000?user=student')
hadoop_fs.create_dir('/test')
info = hadoop_fs.get_file_info('/')
print(info)