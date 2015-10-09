#!/bin/bash
file=${HOME}/scripts/email.properties

GROUPNAME=$1
RECIPIENT=$2
OPERATION=$3

function add {
	IFS=','
	for recipient in $RECIPIENT
	do
        	line=`grep $GROUPNAME $file`
        	echo $line | grep $recipient
        	if [ $? -eq 0 ] ; then
                	echo "Recipient exist"
        	else
                	sed -i "/^${GROUPNAME}/ s/$/,${recipient}/" $file
        	fi
	done
}

function remove {
	IFS=','
	for recipient in $RECIPIENT
	do
        	line=`grep $GROUPNAME $file`
		linenumber=`echo $line | cut -c 1`
        	echo $line | grep $recipient
	        if [ $? -eq 0 ] ; then
        		sed -i "${linenumber}s/,${recipient}//" $file && sed -i "${linenumber}s/=${recipient},/=/" $file
		else
                	echo "recipient doesn't exist"
        	fi
	done

}

$OPERATION
