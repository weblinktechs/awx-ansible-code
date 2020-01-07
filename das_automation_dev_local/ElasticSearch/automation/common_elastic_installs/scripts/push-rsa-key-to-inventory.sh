#!/bin/bash

######
# 1. Read in the hosts from inventory.uat file
# 2. Add the host to the current user's known_hosts
# 3. Append the current user's public RSA key to the user's authorized_keys file on each host
######
INVENTORY="inventory.local"
IFS=$'\n' read -d '' -r -a lines < ${INVENTORY}
for i in "${lines[@]}"
do
  cat ~/.ssh/id_rsa.pub | sshpass -f sshpass.txt ssh ${i} 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys'
done
