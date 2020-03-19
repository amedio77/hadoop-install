# hadoop-install

1. install git
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
vi add_hosts.yml
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

4. ansible yml run
```
./install_hadoop.sh

...


exit
```

5. hadoop namenode format
```

hadoop namenode -format
```



