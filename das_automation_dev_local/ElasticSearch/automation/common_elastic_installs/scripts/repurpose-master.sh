#!/bin/bash

LIMITS=("avu-elserms001.phoenix.local" "avu-elserms002.phoenix.local" "avu-elserms003.phoenix.local" "avu-elserms004.phoenix.local")
INVENTORY="inventory.uat"

for i in "${LIMITS[@]}"; do
  ansible ${i} -m service -a "name=elasticsearch state=stopped" -i ${INVENTORY} --become
  ansible-playbook install-elasticsearch.yml -i ${INVENTORY} \
    --extra-vars "es_ssl=True es_ad_enable=False es_xpack=True" \
    -l ${i} -f 30 --tags=config
  ansible ${i} -m shell -a "echo 'y'|/usr/share/elasticsearch/bin/elasticsearch-node repurpose" --become -i ${INVENTORY}
  ansible ${i} -m service -a "name=elasticsearch state=started" -i ${INVENTORY} --become
  sleep 30
done
