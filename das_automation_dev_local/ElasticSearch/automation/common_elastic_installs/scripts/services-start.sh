#!/bin/bash

INVENTORY="inventory.uat"
ansible master,data,ingest -a "systemctl restart elasticsearch" -i ${INVENTORY} --become
ansible kibana -a "systemctl restart kibana" -i ${INVENTORY} --become
ansible logstash -a "systemctl restart logstash" -i ${INVENTORY} --become
