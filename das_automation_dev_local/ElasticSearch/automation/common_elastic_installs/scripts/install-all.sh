#!/bin/bash

echo "Installing Open JDK, Elasticsearch, Logstash, and Kibana..."
/usr/bin/time -p sh -c 'ansible-playbook install-openjdk.yml -i inventory.local --skip-tags=security; ansible-playbook install-elasticsearch.yml -i inventory.local --skip-tags=security; ansible-playbook install-logstash.yml -i inventory.local --skip-tags=security; ansible-playbook install-kibana.yml -i inventory.local --skip-tags=security; ansible all -a "systemctl status elasticsearch logstash kibana" -i inventory.local'
echo "Done!"
