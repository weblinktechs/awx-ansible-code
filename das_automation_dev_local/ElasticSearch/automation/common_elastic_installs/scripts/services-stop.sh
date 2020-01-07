#!/bin/bash

INVENTORY="inventory.uat"
ansible master,data,ingest -a "systemctl stop elasticsearch" -i ${INVENTORY} --become
ansible kibana -a "systemctl stop kibana" -i ${INVENTORY} --become
ansible logstash -a "systemctl stop logstash" -i ${INVENTORY} --become
