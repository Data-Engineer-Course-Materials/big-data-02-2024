from pywebhdfs.webhdfs import PyWebHdfsClient

webhdfs_client = PyWebHdfsClient('0.0.0.0', 14000, 'student')
webhdfs_client.make_dir('/test')
fs_list = webhdfs_client.list_dir('/')
print(fs_list)
