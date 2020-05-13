
hbase-install

https://www.joinc.co.kr/w/man/12/hadoop/hbase/install

http://mirror.navercorp.com/apache/hbase/


```
cd ~

wget http://mirror.navercorp.com/apache/hbase/stable/hbase-2.2.4-client-bin.tar.gz

wget http://mirror.navercorp.com/apache/hbase/stable/hbase-2.2.4-bin.tar.gz

tar -xvzf hbase-2.2.4-bin.tar.gz

mv hbase-2.2.4 hbase

$ vi ~/.bashrc
export HBASE_HOME=/home/centos/hbase
export PATH=$PATH:$HBASE_HOME/bin
export HBASE_PID_DIR=/home/centos/hbase/pid

$ cd ~/hbase/conf

1) hbase-site.xml
$ vi hbase-site.xml

<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>hbase.rootdir</name>
        <value>hdfs://hmaster:54310/hbase</value>
    </property>
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
    </property>
    <property>
        <name>hbase.zookeeper.quorum</name>
        <value>hmaster,hworker-1,hworker-2</value>
    </property>
    <property>
        <name>dfs.replication</name>
        <value>3</value>
    </property>
    <property>
      <name>hbase.unsafe.stream.capability.enforce</name>
      <value>false</value>
    </property>
    <property>
        <name>hbase.zookeeper.property.clientPort</name>
        <value>2181</value> 
    </property> 
</configuration>

## 확인
$ hadoop fs -df -h
Filesystem               Size   Used  Available  Use%
hdfs://hadoop01:9000  10.6 G  184 K      5.1 G    0%


2) habase-env.sh

vi hbase-env.sh
export HBASE_MANAGES_ZK=false
export HBASE_PID_DIR=/home/centos/hbase/pid

3) regionservers

vi regionservers

hmaster
hworker-1
hworker-2

4) 

hadoop dfsadmin -safemode leave

## worker node 에 복사
scp -r ~/hbase hworker-1:/home/centos/
scp -r ~/hbase hworker-2:/home/centos/

```

hbase 실행

```
## 실행
~/hbase/bin/start-hbase.sh


## hmaster
$ jps 
31713 NodeManager
31425 SecondaryNameNode
32146 HMaster
32306 HRegionServer
31579 ResourceManager
1773 Jps
31087 NameNode


## hworker
$ jsp
9697 Jps
8786 DataNode
9103 HRegionServer

```

hbase 테스트

```
#테이블 생성
$ hadoop fs -mkdir /hbase/master

$ hbase shell
hbase(main):001:0> list
TABLE
0 row(s) in 0.3120 seconds
=> []


hbase(main):002:0> status
1 active master, 0 backup masters, 3 servers, 0 dead, 0.6667 average load




## create '<table name','<column family>'


hbase(main):003:0> create 'emps', 'personal data', 'professional data'
0 row(s) in 1.3470 seconds


=> Hbase::Table - emps
hbase(main):004:0> list
TABLE 
emps
1 row(s) in 0.0190 seconds


=> ["emps"]

## 데이터 입력
##put ’<table name>’,’row1’,’<colfamily:colname>’,’<value>’

hbase(main):010:0> put 'emps', '1', 'personal data:name', 'yundream'
0 row(s) in 0.1430 seconds
hbase(main):011:0> put 'emps', '1', 'personal data:city', 'seoul'
0 row(s) in 0.0160 seconds
hbase(main):015:0> put 'emps', '1', 'professional data:designation', 'manager'
0 row(s) in 0.0230 seconds
hbase(main):016:0> put 'emps', '1', 'professional data:salary', '50000'
0 row(s) in 0.0140 seconds



##scan을 이용해서 데이터를 읽었다.
##
hbase(main):018:0> scan 'emps'
ROW                              COLUMN+CELL
 1                               column=personal data:city, timestamp=1493549649430, value=seoul
 1                               column=personal data:name, timestamp=1493549630369, value=yundream
 1                               column=professional data:designation, timestamp=1493558408019, value=manager 
 1                               column=professional data:salary, timestamp=1493558423673, value=50000
1 row(s) in 0.0390 seconds


##get을 이용해서 특정 row를 읽을 수 있다.

hbase(main):019:0> get 'emps', '1'
COLUMN                           CELL
 personal data:city              timestamp=1493549649430, value=seoul
 personal data:name              timestamp=1493549630369, value=yundream
 professional data:designation   timestamp=1493558408019, value=manager
 professional data:salary        timestamp=1493558423673, value=50000
4 row(s) in 0.0260 seconds

```
