./hdfs dfs -mkdir /bfs-input-1
./hdfs dfs -put /input-1.txt /bfs-input-1
./hdfs dfs -mkdir /bfs-output-2
./hadoop jar /$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar -iput /bfs-output-1/part_0000 -output /bfs-output-2 -mapper -reducer

./hdfs dfs -cat /bfs-output-3/part_0000