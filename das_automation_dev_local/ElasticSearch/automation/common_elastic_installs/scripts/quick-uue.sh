#!/bin/bash

DATE=`date '+%Y-%m-%d-%s'`
OUTFILE="${DATE}"
OUTFILE_PATH="files/uuencodes"
OUTFILE_DESTINATION="${OUTFILE_PATH}/${OUTFILE}.uue"
TEMPFILE="${OUTFILE_PATH}/for-transfer.zip"
zip -q -9 -r --exclude="*.git*" --exclude="*files*" --exclude="*vagrant*" --exclude="*venv*" ${TEMPFILE} .
uuencode ${TEMPFILE} ${OUTFILE}.zip > ${OUTFILE_DESTINATION}
rm ${TEMPFILE}
ls -lah "${OUTFILE_DESTINATION}"
atom "${OUTFILE_DESTINATION}"
