1.mysql install

```
sudo vi /etc/yum.repos.d/MariaDB.repo

[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1


##yum으로 MariaDB 검색 및 설치

yum list |grep -i maria

sudo yum install MariaDB-server.x86_64 -y

##============설정=============
##실행
sudo systemctl start mariadb


#root 비밀번호 설정
/usr/bin/mysqladmin -u root password 'crossent1234'


#접속
mysql -u root -p

#hive user 생성
CREATE USER 'hive'@'%' IDENTIFIED BY 'hive1234';
GRANT ALL ON *.* TO 'hive'@LOCALHOST IDENTIFIED BY 'hive1234';
FLUSH PRIVILEGES;

exit


#hive 유저로 접속
mysql -u hive -p


#hive database 생성
create database hive;

```

2. hive install

```
##============하이브 2.3.3 다운로드=============
## https://hive.apache.org/

#wget http://mirror.navercorp.com/apache/hive/stable-2/apache-hive-2.3.3-bin.tar.gz

wget http://mirror.navercorp.com/apache/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz

wget http://mirror.navercorp.com/apache/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz


tar zxvf ./apa*

mv ./apache-hive-3.1.2-bin ./hive

##============환경파일 설정============
1)
vi /etc/profile


2)
vi .bashrc

export HIVE_HOME=/home/centos/hive
export PATH=$PATH:$HIVE_HOME/bin


##============jdbc mariadb 커넥터 다운로드============
## 웹주소 : https://downloads.mariadb.org/connector-java/2.2.3/
## https://downloads.mariadb.org/connector-java/2.6.0/
## https://downloads.mariadb.com/Connectors/java/connector-java-2.6.0

cd /home/centos/hive/lib
wget https://downloads.mariadb.com/Connectors/java/connector-java-2.6.0/mariadb-java-client-2.6.0.jar


===========하이브설정==============

1)
cd /home/centos/hive/conf
cp -rp ./hive-env.sh.template ./hive-env.sh

2)
vi hive-env.sh

export HADOOP_HOME=/home/centos/hadoop

3) vi hive-site.xml

<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>hive.metastore.local</name>
        <value>false</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:mariadb://localhost:3306/hive?createDatabaseIfNotExist=true</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>org.mariadb.jdbc.Driver</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionUserName</name>
        <value>hive</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>hive1234</value>  
    </property>
</configuration>i<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>hive.metastore.local</name>
        <value>false</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:mariadb://localhost:3306/hive?createDatabaseIfNotExist=true</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>org.mariadb.jdbc.Driver</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionUserName</name>
        <value>hive</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>hive1234</value>  
    </property>
</configuration>

##=========MariaDB 연결 초기화 (mysql로 써야함..)============
cd /home/centos/hive

bin/schematool -initSchema -dbType mysql

##에러발생시 아래 실행 ( guava-19.0.jar --> guava-27.0-jre.jar )
$ rm /home/centos/hive/lib/guava-19.0.jar
$ cp /home/centos/hadoop/share/hadoop/hdfs/lib/guava-27.0-jre.jar /home/centos/hive/lib/


## test
hdfs dfs -mkdir /tmp
hdfs dfs -mkdir -p /home/centos/hive/warehouse
hdfs dfs -chmod g+w /home/centos/hive/warehouse


hdfs dfs -ls -R /



CREATE TABLE airline_delay
CREATE TABLE airline_delay(Year INT, Month INT, DayofMont INT, DayOfWeek INT, DepTime INT, CRSDepTime INT, ArrTime INT, CRSArrTime INT, UniqueCarrier STRING, FlightNum INT, TaiNum STRING, ActualElapsedTime INT, CRSElapsedTime INT, AirTime INT, ArrDelay INT, DepDelay INT, Origin STRING, Dest STRING, Distance INT, TaxiIn INT, TaxiOut INT, Cancelled INT, CancellationCode STRING COMMENT 'A=carrier, B=weather, C=NAS, D=security', Diverted INT COMMENT '1=yes, 0=no', CarrierDelay STRING, WeatherDelay STRING, NASDelay STRING, SecurityDelay STRING, LateAircraftDelay STRING) COMMENT 'The data consitsts of filght arrival and departure details for all commercial flights within the USA, froom October 1987 to April 2008' PARTITIONED BY (delayYear INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' STORED AS TEXTFILE;


hive> 
CREATE TABLE employee (
       id         String,
       name       String,
       lists      ARRAY<STRING>,
       maps       MAP<STRING, STRING>
     ) 
     ROW FORMAT DELIMITED 
       FIELDS TERMINATED BY '\t'
       ESCAPED BY '\\'
       COLLECTION ITEMS TERMINATED BY ','
       MAP KEYS TERMINATED BY '='
       LINES TERMINATED BY '\n'
       NULL DEFINED AS 'null'
       ;


test.csv

id-1 john a,b,c,d k1=v1,k2=v2
id-2 sam e,f,g,h k3=v3,k4=v4
id-3 david i,j,k,l k5=v5,k6=v6
id-4 k7=v7

load data local inpath '/home/centos/airline/test.csv' overwrite into table employee;

hive> load data local inpath '/home/centos/airline/test.csv' overwrite into table employee;
Loading data to table default.employee
OK
Time taken: 4.506 seconds


hive> select * from employee;
OK
id-1    john    ["a","b","c","d"]    {"k1":"v1","k2":"v2"}
    NULL    NULL    NULL
id-2    sam    ["e","f","g","h"]    {"k3":"v3","k4":"v4"}
    NULL    NULL    NULL
id-3    david    ["i","j","k","l"]    {"k5":"v5","k6":"v6"}
    NULL    NULL    NULL
id-4        []    {"k7":"v7"}
Time taken: 3.152 seconds, Fetched: 7 row(s)

```

https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL#LanguageManualDDL-CreateTable



