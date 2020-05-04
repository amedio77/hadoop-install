# hadoop-install

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
vi hosts/add_hosts.yml
...
  tasks:
  - name: Add "/etc/hosts"
    blockinfile:
      path: /etc/hosts
      block: |
        10.0.0.x hmaster    # ip 수정
        10.0.0.x hworker-1  # ip 수정
        10.0.0.x hworker-2  # ip 수정
    become: yes
...    



vi hosts/add_all_host.yml
...
  tasks:
  - name: Add "/etc/hosts"
    blockinfile:
      path: /etc/hosts
      block: |
        10.0.0.x hmaster    # ip 수정
        10.0.0.x hworker-1  # ip 수정
        10.0.0.x hworker-2  # ip 수정
    become: yes
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

7. master, worker 모든 node 에서 시작

```
source ~/.bashrc

~/hadoop/sbin/start-all.sh &

```

7. 확인
```
## master node
$ jps
30225 NameNode
30915 ResourceManager
31221 Jps
30703 SecondaryNameNode

## worker node
$ jps
25264 NodeManager
24934 SecondaryNameNode
25158 ResourceManager
24764 DataNode
25647 Jps


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

