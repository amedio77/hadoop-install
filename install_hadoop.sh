

sudo yum install epel-release -y

sudo yum install ansible -y


cat <<EOF> ~/.ssh/kepri-msa.pem 
-----BEGIN RSA PRIVATE KEY-----
-----END RSA PRIVATE KEY-----
EOF

chmod 600 ~/.ssh/kepri-msa.pem

sudo -- sh -c "echo 10.0.0.5 hmaster >> /etc/hosts"
sudo -- sh -c "echo 10.0.0.3 hworker-1 >> /etc/hosts"
sudo -- sh -c "echo 10.0.0.15 hworker-2 >> /etc/hosts"


sudo -- sh -c "echo hmaster >> /etc/ansible/hosts"
sudo -- sh -c "echo hworker-1 >> /etc/ansible/hosts"
sudo -- sh -c "echo hworker-2 >> /etc/ansible/hosts"

ansible-playbook  --private-key=~/.ssh/kepri-msa.pem add_known_hosts.yml

ansible-playbook  --private-key=~/.ssh/kepri-msa.pem install_hadoop.yml
