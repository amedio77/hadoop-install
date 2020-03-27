
sudo yum install epel-release -y

sudo yum install ansible -y


cat <<EOF> ~/.ssh/kepri-msa.pem 
-----BEGIN RSA PRIVATE KEY-----

-----END RSA PRIVATE KEY-----
EOF

chmod 600 ~/.ssh/kepri-msa.pem

#sudo -- sh -c "echo 10.0.0.7 hmaster >> /etc/hosts"
#sudo -- sh -c "echo 10.0.0.14 hworker-1 >> /etc/hosts"
#sudo -- sh -c "echo 10.0.0.3 hworker-2 >> /etc/hosts"

#sudo -- sh -c "echo hmaster >> /etc/ansible/hosts"
#sudo -- sh -c "echo hworker-1 >> /etc/ansible/hosts"
#sudo -- sh -c "echo hworker-2 >> /etc/ansible/hosts"

#scp -i ~/.ssh/kepri-msa.pem centos@10.0.0.8:~/hadoop-3.2.1.tar.gz .

