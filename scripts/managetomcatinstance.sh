#!/bin/bash

STATUS=$1
TARGET_SERVERS=$2
TOMCAT_INSTANCES=$3

echo $STATUS $TARGET_SERVERS $TOMCAT_INSTANCES
LINE=`grep "$TARGET_SERVERS" ${HOME}/scripts/targetservers_ip`
if [ -z $LINE ]; then 
	exit
else
IP=`echo $LINE | cut -d'=' -f2`
echo "start*******"
ssh -t -t tomcat@${IP} "sudo service tomcat-$TOMCAT_INSTANCES $STATUS"
fi

