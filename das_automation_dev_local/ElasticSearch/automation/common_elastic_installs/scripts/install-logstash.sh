#!/bin/bash

ls_heap_size="1g"
es_ssl="true"
es_xpack="true"
es_xpack_monitoring="true"
install_java="false"
inventory="inventory.local"
limit="logstash"
parallelism=5

ansible-playbook install-logstash.yml \
  -i ${inventory} \
  -f ${parallelism} \
  -l ${limit} \
  --extra-vars "ls_heap_size=${ls_heap_size} es_ssl=${es_ssl} es_xpack_monitoring=${es_xpack_monitoring} es_xpack=${es_xpack} install_java=${install_java}"
