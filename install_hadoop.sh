

sudo yum install epel-release -y

sudo yum install ansible -y


cat <<EOF> ~/.ssh/kepri-msa.pem 
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEApS1l1Nxryzz6Ncuvfd2XZCCXToA6YtY4uKDXbDpqVDrnRD1X
zlrIJpZfKtLcVC/KHDR9IEwaJlvy49MlrwIPM8zhbT/+AJNh6UEOGznl+gWJoBpO
mRlPjWIIK2NwPTXpp2YY2d3X5pTiT7jUo45kY9moSq2DyL9ckT4PwvlQgAWeXNrB
wjhsNu4UoE6LQdz2ZKakfznz8EVZMXv0DzOb6vy+asQtKSHPfY8Ha084FtuqLITE
whhg8SpjEkABDU54azEUGE0dItiiEVyKhZ20JhXoYojbcr3pBnM+sghMwzkczsL0
gM/FOymYSkqzNyrg7fAz9yvhxa4sOz1exOsYGwIDAQABAoIBAQCaSMhIRkcNhHx2
CTZ3i6agKO0LryxaK5y5n8r4VawB1y8zh1Tf893mZSipWGHi5OyU4dZKd6spT1OV
yCD30iWfDe02XcKEiSW4eUKS3cbZfZiqikgGKyUqe3oEBRLOqfAAo5Xs0pGa2FB3
hL5hs1xEBAd1EZP5y/zL0btpM/UkThp/72+OU7t7sL2QsGPAvgI+5zaUh1ULY+qB
qurdCR3FDnj70NMFR3MkR4CTnzZ90roUh0czVnl9TiHUsW5db6EAgiyJ7Z8Xohle
nlsEbVQllDFZzowPbCcLB8XMyxJ3JnOUHBPv4H0UYc+YiquVFtOSf9rXSj9Iy+Id
l+MgVMxxAoGBANklGOUrtzuW8oJ2yXZzq8/lQMEm5Vj7rlji6DL3WGcdh+r0LliQ
gwemI2U5TptVGZ1bbP/P0ZI3mPfdszzV4PYTGNxBxVI0Fc9O+7o40t+ECRiefdmP
yAYmpzfoU14oNickZ43TNZhp4anShwTAxFpriSb0EcG+zxWC/gB7Y9fJAoGBAMK7
yXEJZSAd7BE4tpK7kyanGp9356IMmlsHRcmQ6pahhPoHO4I6OPsn0PwIOau6bAGW
Su27DgzmOY4FYEL27dkgxk0ftdPvdnodcSVVRq6IB0EH1EQKnPeMla2eCf8k8jqJ
QhIUvZ0FRqkIbSbO8rPi/wS3+O4pJF87uHzvoOrDAoGAYNoCC51/Aa4nBnfTDekz
1etsAXrGyvSe4/h5Ftpp7LwoNmypC0mRl+TLXse7vt6rKRtxN3xK/kucB9ozqsu+
piMIcJ1JVIv0ul2BO6NCsv0iTX/LpDFURyIQbYhLPvDyjmzXX1O4UP3Q8Dz9ieos
6iOSrfQow2DG3tJpVm+yrbkCgYBOxUNw9Anx+eiZ9sTziei2Q/Yi94+9Hzf5BnIW
XQZntCJkOTS7Mu4Fuk9xA6rAaoJyCed5TqcaVK6HYmlT7Sq9H+LXI7KbbkwQjYRN
Q7d5thCpH4+fjmN8R2PsfPcyPDG3t/n/8l/Y+l9g1MXCYwgN+A6MTBbnz8CkvTWd
ZBlFnQKBgQCcoXFcdCWq3e9rmcYR3RRa+Ggkp+vmlaf4zrIrkQyBtpoRTdP1vPAJ
UxAd111mKhXjL8rHqMhmE5wZKINJLqjrChqIAY103tRmvoJVIdAFlMeiMvZK9V71
9W7oX4FgZfSKdnAE5s22RqzleAD3MfnCQN+CNtWOv22hnNfEPdAT2A==
-----END RSA PRIVATE KEY-----
EOF

chmod 600 ~/.ssh/kepri-msa.pem

#sudo -- sh -c "echo 10.0.0.7 hmaster >> /etc/hosts"
#sudo -- sh -c "echo 10.0.0.14 hworker-1 >> /etc/hosts"
#sudo -- sh -c "echo 10.0.0.3 hworker-2 >> /etc/hosts"

#sudo -- sh -c "echo hmaster >> /etc/ansible/hosts"
#sudo -- sh -c "echo hworker-1 >> /etc/ansible/hosts"
#sudo -- sh -c "echo hworker-2 >> /etc/ansible/hosts"

ansible-playbook  --private-key=~/.ssh/kepri-msa.pem add_hosts.yml

ansible-playbook  --private-key=~/.ssh/kepri-msa.pem add_known_hosts.yml

ansible-playbook  --private-key=~/.ssh/kepri-msa.pem add_authorized_keys.yml

ansible-playbook  --private-key=~/.ssh/kepri-msa.pem install_hadoop.yml
