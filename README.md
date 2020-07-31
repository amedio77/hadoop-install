# hadoop-install 설치확인

## hadoop 설치 및 클러스터 확인
### version 3.x
admin http://hmaster:9870

yarn http://hmaster:8088

### version 2.7.9
admin http://hmaster:50070
yarn  http://hmaster:8088


##  spark 설치 확인
web ui http://hmaster:8089/

##  zookeeper 설치 확인
각 서버의 주키퍼 데몬을 실행한다.
jps 명령으로 확인하면 QuorumPeerMain이 동작하고 있는 것을 확인할 수 있다.

```
$ jps
5595 QuorumPeerMain
...
```

- bin/zkCli.sh -server 127.0.0.1:2181

##  hbase 설치 확인

jps 명령으로 확인하면 master 에서는 HMaster,HRegionServer worker 에서는 HRegionServer
의 동작을 확인할 수 있다.
```
## hmaster
$ jps 
32146 HMaster
32306 HRegionServer
...

## hworker
$ jsp
9103 HRegionServer
...

```
