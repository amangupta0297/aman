#!/bin/bash
JOBS=$1
OPERATION=$2

IFS=","
for job_name in $JOBS
  do
    java -jar ${HOME}/jenkins-cli.jar -s http://172.31.10.238:8080 $OPERATION-job $job_name --username sandeep.rawat --password sandy724
  done
unset IFS
