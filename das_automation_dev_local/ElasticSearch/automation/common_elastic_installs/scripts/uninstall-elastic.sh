#!/bin/bash

GROUP="master"
DIRS_TO_DELETE=("/etc/elasticsearch" "/usr/share/elastichsearch" "/data/elasticsearch" "/data01/elasticsearch")
ansible ${GROUP} -a "yum remove -y elasticsearch*" -i inventory.uat --become
for i in "${DIRS_TO_DELETE[@]}"; do
  ansible ${GROUP} -a "rm -rf ${i}" -i inventory.uat --become
done
