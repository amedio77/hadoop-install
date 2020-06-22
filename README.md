# hadoop-install 설치확인

## hadoop 설치 및 클러스터 확인

admin http://hmaster:9870

yarn http://hmaster:8088

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
