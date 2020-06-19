spark install

https://kogun82.tistory.com/167

```
# http://spark.apache.org/downloads.html

wget http://mirror.navercorp.com/apache/spark/spark-3.0.0-preview2/spark-3.0.0-preview2-bin-hadoop3.2.tgz

tar -xvzf spark-3.0.0-preview2-bin-hadoop3.2.tgz

mv spark-3.0.0-preview2-bin-hadoop3.2/ spark/

1) spark-defaults.conf

cp -rp ./spark-defaults.conf.template ./spark-defaults.conf

vi spark-defaults.conf

spark.master spark://hmaster:7077


2) spark-env.sh 

cp -rp ./spark-env.sh.template ./spark-env.sh 

vi spark-env.sh

export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64
export HADOOP_CONF_DIR=~/hadoop/etc/hadoop
SPARK_MASTER_IP=hmaster
SPARK_MASTER_PORT=7077

export SPARK_WORKER_INSTANCES=1
export SPARK_WORKER_MEMORY=8192m
export SPARK_WORKER_CORES=8
export SPARK_MASTER_OPTS="-Dspark.deploy.defaultCores=5"

3) slaves

cp -rp ./slaves.template ./slaves

vi slaves

# localhost
hworker-1
hworker-2

4) log4j.properties

cp -rp ./log4j.properties.template ./log4j.properties

vi log4j.properties

```

Spark 설정 worker node 에 복사

```
scp -r ~/spark hworker-1:/home/centos/

scp -r ~/spark hworker-2:/home/centos/

```


Spark start / stop

```
#master node
sbin/start-all.sh

#slave node
sbin/start-slave.sh 'spark://hmaster:7077'


#master node
sbin/stop-all.sh

#slave node
sbin/stop-slave.sh 'spark://hmaster:7077'

```

web ui
http://hmaster:8080/

test

```
cd ~/spark

./bin/spark-submit \
--master spark://hmaster:7077 \
--class org.apache.spark.examples.SparkPi \
~/spark/examples/jars/spark-examples*.jar \
100

```



