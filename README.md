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



