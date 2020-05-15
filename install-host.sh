
ansible-playbook --private-key ~/.ssh/kepri-msa.pem host-local-env.yml \
 -e 'input_host="10.1.8.14 hmaster\n10.1.8.3 hworker-1\n10.1.8.5 hworker-2" \
     input_ansible_host="[master]\nhmaster\n[workers]\nhworker-1\nhworker-2"'

ansible-playbook --private-key ~/.ssh/kepri-msa.pem host-env.yml \
 -e 'input_host="10.1.8.14 hmaster\n10.1.8.3 hworker-1\n10.1.8.5 hworker-2"'
