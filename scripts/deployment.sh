#!/bin/bash 

SERVER_IP=$1
WAR=$2
WEBAPPS_NAME=$3
TARGET=$4
APP_NAME=$5
scp $TARGET/$WAR  tomcat@${SERVER_IP}:/tmp
ssh -t -t tomcat@${SERVER_IP} "/srv/tomcat/$WEBAPPS_NAME/deployWarToTomcatService.sh $WEBAPPS_NAME $WAR $APP_NAME"
