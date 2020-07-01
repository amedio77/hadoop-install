# install git
sudo yum install git -y

# install wget
sudo yum install wget -y

# 하둡설치파일 다운로드 세팅
wget http://apache.claz.org/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz

tar -xvzf hadoop-3.2.1.tar.gz

mv hadoop-3.2.1 hadoop

rm -rf hadoop-3.2.1.tar.gz

#하둡 설정파일 설정
git clone https://github.com/amedio77/hadoop-install.git
cp ~/hadoop-install/hadoop-env/*.*  ~/hadoop/etc/hadoop/

# jdk 1.8 설치
sudo yum install -y java-1.8.0-openjdk-devel.x86_64

# 환경변수 설정
cat <<EOF>>/home/centos/.bashrc
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64
export HADOOP_HOME=~/hadoop/
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$HADOOP_HOME/share/hadoop/tools/lib/*
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
EOF


# dfs dir 생성
mkdir -p ~/hadoop/pids
mkdir -p ~/hadoop/etc/hadoop/dfs/data
mkdir -p ~/hadoop/etc/hadoop/dfs/name

chmod 7055 ~/hadoop/pids
chmod 7055 ~/hadoop/etc/hadoop/dfs/data
chmod 7055 ~/hadoop/etc/hadoop/dfs/name

cd ~

# spark 설치 파일 다운로드
wget http://mirror.navercorp.com/apache/spark/spark-3.0.0-preview2/spark-3.0.0-preview2-bin-hadoop3.2.tgz
tar -xvzf spark-3.0.0-preview2-bin-hadoop3.2.tgz
mv spark-3.0.0-preview2-bin-hadoop3.2/ spark/

# zookeeper 설치 파일 다운로드
wget http://archive.apache.org/dist/zookeeper/zookeeper-3.6.1/apache-zookeeper-3.6.1-bin.tar.gz
tar -xvzf apache-zookeeper-3.6.1-bin.tar.gz
mv apache-zookeeper-3.6.1-bin zookeeper

# hbase 설치 파일 다운로드
wget http://mirror.navercorp.com/apache/hbase/stable/hbase-2.2.4-bin.tar.gz
tar -xvzf hbase-2.2.4-bin.tar.gz
mv hbase-2.2.4 hbase

# hive 설치 파일 다운로드
wget http://mirror.navercorp.com/apache/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz
tar zxvf ./apa*
mv ./apache-hive-3.1.2-bin ./hive


