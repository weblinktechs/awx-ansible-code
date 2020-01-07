#!/bin/bash

es_jvm_heap_size_master="28g"
es_jvm_heap_size_default="60g"
es_ssl="true"
es_xpack="true"
es_xpack_monitoring="true"
install_java="false"
inventory="inventory.uat"
limit="master"
parallelism=5

ansible-playbook install-elasticsearch.yml \
  -i ${inventory} \
  -f ${parallelism} \
  -l ${limit} \
  --extra-vars "es_jvm_heap_size_master=${es_jvm_heap_size_master} es_jvm_heap_size_default=${es_jvm_heap_size_default} es_ssl=${es_ssl} es_xpack_monitoring=${es_xpack_monitoring} es_xpack=${es_xpack} install_java=${install_java}" --tags=config
