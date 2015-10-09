#!/bin/bash

source /opt/bigparser/jenkins/scripts/function/file_function.sh

SRC_DIR=/var/lib/jenkins/jobs
TGT_DIR=/opt/bigparser/jenkins/jobs

JOBS_NAME=`getDirs $SRC_DIR`

cd ${SRC_DIR}
for jobName in ${JOBS_NAME}
do
	echo "Synching job $jobName"
	mkdir -p -v ${TGT_DIR}/${jobName}

	cp -v ${SRC_DIR}/${jobName}/config.xml ${TGT_DIR}/${jobName}/config.xml
done



