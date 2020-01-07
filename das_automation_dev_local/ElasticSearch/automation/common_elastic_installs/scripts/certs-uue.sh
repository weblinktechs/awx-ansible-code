#!/bin/bash

DATE=`date +%s`
OUTFILE="ssl-certificates-${DATE}"
OUTFILE_PATH="files/uuencodes"
OUTFILE_DESTINATION="${OUTFILE_PATH}/${OUTFILE}.uue"
TEMPFILE="${OUTFILE_PATH}/for-transfer-${DATE}.zip"
CERTPATH="./files/ssl/*.p12"
zip -q -9 -r ${TEMPFILE} ${CERTPATH}
uuencode ${TEMPFILE} ${OUTFILE}.zip > ${OUTFILE_DESTINATION}
rm ${TEMPFILE}
ls -lah "${OUTFILE_DESTINATION}"
atom "${OUTFILE_DESTINATION}"
