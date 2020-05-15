# hadoop-install

https://medium.com/@jootorres_11979/how-to-set-up-a-hadoop-3-2-1-multi-node-cluster-on-ubuntu-18-04-2-nodes-567ca44a3b12

0. hadoop file copy
```
scp -i ~/.ssh/kepri-msa.pem ./hadoop-3.2.1.tar.gz centos@10.0.0.x:~ # 
...

```


1. install git & 
```
sudo yum install git -y

```

2. clone hadoop install src
```
git clone https://github.com/amedio77/hadoop-install.git
cd hadoop-install
```

3. change node ip
```
vi install-host.sh
...

ansible-playbook --private-key ~/.ssh/kepri-msa.pem host-local-env.yml \
 -e 'input_host="10.1.8.14 hmaster\n10.1.8.3 hworker-1\n10.1.8.5 hworker-2" \
     input_ansible_host="[master]\nhmaster\n[workers]\nhworker-1\nhworker-2"'

ansible-playbook --private-key ~/.ssh/kepri-msa.pem host-env.yml \
 -e 'input_host="10.1.8.14 hmaster\n10.1.8.3 hworker-1\n10.1.8.5 hworker-2"'
 
...    

```

4. install ansible & create pem file 
```
./install-env.sh
...

```

5. vm host ssh auto pass 
```
./install-host.sh
...

```


6. hadoop install
```

./ansible-playbook --private-key ~/.ssh/kepri-msa.pem install_hadoop.yml
```




7. master node 에서 시작

```
source ~/.bashrc

$ start-dfs.sh

$ start-yarn.sh 

```

7. 확인
```
## master node
$ jps
8273 Jps
6473 SecondaryNameNode
6254 NameNode
7790 ResourceManager

## worker node
$ jps
2002 Jps
1044 DataNode
1686 NodeManager


```

8. haproxy
```
listen hadoop-admin
    balance  roundrobin
    bind :9870
    log global
    mode tcp
    option tcplog
    server pregid1 10.1.8.10:9870 check

listen hadoop-yarn
    balance  roundrobin
    bind :8088
    log global
    mode tcp
    option tcplog
    server pregid1 10.1.8.10:8088 check

sudo setsebool -P haproxy_connect_any=1

sudo service haproxy restart

```
admin
http://101.55.126.207:9870

yarn
http://101.55.126.207:8088

node-1
http://101.55.126.207:9864

node-2
http://101.55.126.207:9865

jobhistory
http://101.55.126.207:19888

