# hadoop-install

1.
```
sudo yum install git -y
```

2.
```
git clone https://github.com/amedio77/hadoop-install.git
cd hadoop-install
```

3.
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
4. 
```
./install_hadoop.sh
```
