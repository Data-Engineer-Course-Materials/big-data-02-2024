import subprocess


def run_cmd(args_list):
    print('Running command {0}'.format(' '.join(args_list)))
    proc = subprocess.Popen(args_list, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    s_output, s_err = proc.communicate()
    s_return = proc.returncode
    return s_output, s_err, s_return


(s_output, s_err, s_return) = run_cmd(['./$(HADOOP_HOME)/bin/hdfs', 'dfs', '-ls', '/'])
print(s_output)
