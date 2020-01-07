#!/bin/bash

##############################
# Utility for converting customer-issued pfx certificates to p12
# Update the ./scripts/certpass.txt file with the certificate password (do not commit to git)
# Assumes certificates to convert are located in ./files/ssl relative to root
##############################

CERTPATH="./files/ssl/"
PASSWORDFILE="./scripts/certpass.txt"
IFS=$'\n' read -d '' -r -a PASSWORD < ${PASSWORDFILE}

echo "Converting all certificates in ${CERTPATH}"
for CERTIFICATE in ${CERTPATH}*pfx; do
  OUTFILE="${CERTIFICATE}.p12"
  TEMPFILE="${CERTIFICATE}.temp.pem"
  openssl pkcs12 -in ${CERTIFICATE} -nodes -out ${TEMPFILE} -passin pass:${PASSWORD} -passout pass:""
  openssl pkcs12 -export -in ${TEMPFILE} -out ${OUTFILE} -passin pass:"" -passout pass:""
  rm -rf ${TEMPFILE}
  echo "Converted ${CERTIFICATE} => ${OUTFILE}"
done
echo "Done."
