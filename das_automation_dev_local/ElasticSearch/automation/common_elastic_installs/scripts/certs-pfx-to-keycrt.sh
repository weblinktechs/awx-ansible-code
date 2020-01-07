#!/bin/bash

##############################
# Utility for converting customer-issued pfx certificates to key/crt for Kibana
# Update the ./scripts/certpass.txt file with the certificate password (do not commit to git)
# Assumes certificates to convert are located in ./files/ssl relative to root
##############################

CERTPATH="./files/ssl/"
INFILE="${CERTPATH}avu-elserkb001.phoenix.local.pfx"
PASSWORDFILE="./scripts/certpass.txt"
IFS=$'\n' read -d '' -r -a PASSWORD < ${PASSWORDFILE}
echo "Converting ${INFILE} to .key/.crt"
KEYOUT="${INFILE}.key"
CERTOUT="${INFILE}.crt"
openssl pkcs12 -in ${INFILE} -nocerts -out ${KEYOUT} -passin pass:${PASSWORD} -passout pass:${PASSWORD}
openssl pkcs12 -in ${INFILE} -clcerts -nokeys -out ${CERTOUT} -passin pass:${PASSWORD} -passout pass:${PASSWORD}
printf "Converted ${INFILE} =>\n  1. ${KEYOUT}\n  2. ${CERTOUT}\n"

echo "Done."
exit 0
