zookeeper install

http://develop.sunshiny.co.kr/886
https://blog.naver.com/melomelo11/221362806126
https://cafe.naver.com/hadoopkr/57 --> 가장 자세함

```
##https://zookeeper.apache.org/index.html

wget http://archive.apache.org/dist/zookeeper/zookeeper-3.6.1/apache-zookeeper-3.6.1-bin.tar.gz


tar -xvzf apache-zookeeper-3.6.1-bin.tar.gz

mv apache-zookeeper-3.6.1-bin zookeeper

1)

cd zookeeper/conf

cp zoo_sample.cfg zoo.cfg

vi zoo.cfg

dataDir=/home/centos/zookeeper/tmp
server.1=hmaster:2888:3888
server.2=hworker-1:2888:3888
server.3=hworker-2:2888:3888

2)

cd /home/centos/zookeeper/tmp

vi myid 

1 ## 노드1->1, 노드2->2, 노드3->:3

3) 

vi ~/.bashrc

export ZOOKEEPER_HOME=/home/centos/zookeeper
export PATH=$PATH:$ZOOKEEPER_HOME/bin

source ~/.bashrc

## 

## 파일 노드에 복사

scp -r ~/zookeeper hworker-1:/home/centos/
scp -r ~/zookeeper hworker-2:/home/centos/

##실행 --> 모든 노드에서 실행해 주어야 함
cd ~/zookeeper

bin/zkServer.sh start


##확인
bin/zkCli.sh -server 127.0.0.1:2181

```
