#!/bin/bash
star="********************************************************************"
JOBS=$1

function add {
	IFS=','
	for job_name in $JOBS 
	do
		echo $star
		echo $job_name
		Jobconfigfile=/var/lib/jenkins/jobs/$job_name/config.xml
		trigger=$(grep -c '<triggers>' $Jobconfigfile)
		hudson=$(grep -c '<hudson.triggers.SCMTrigger>' $Jobconfigfile)
		spec=$(grep -c '<spec> H/5 * * * *</spec>' $Jobconfigfile)

		if [ $trigger -eq 1 ] ; then
			if  [ $hudson -eq 1 ]; then
				if [ $spec -eq 1 ]; then
					echo spec exist 
				else 
					sed -i 's/<spec>.*/<spec>H\/5 * * * *<\/spec>/' $Jobconfigfile
				fi
			else
	sed -i '/<triggers>/a <hudson.triggers.SCMTrigger> \
      <spec>H/5 * * * *</spec> \
      <ignorePostCommitHooks>false</ignorePostCommitHooks> \
    </hudson.triggers.SCMTrigger>' $Jobconfigfile
			fi
		else
sed -i 's/<triggers\/>.*/<triggers> \
    <hudson.triggers.SCMTrigger> \
      <spec> H\/5 * * * *<\/spec> \
      <ignorePostCommitHooks>false<\/ignorePostCommitHooks> \
    <\/hudson.triggers.SCMTrigger> \
     <\/triggers>/' $Jobconfigfile
		fi
	done
}

function remove {
	IFS=','
	for job_name in $JOBS
	do
		echo $star
		echo $job_name
		Jobconfigfile=/var/lib/jenkins/jobs/$job_name/config.xml
		hudsonblock=$(grep -c '<hudson.triggers.SCMTrigger>' $Jobconfigfile)

		if [ $hudsonblock -eq 1 ] ; then

sed -i '/<hudson.trig.*/d' $Jobconfigfile
sed -i '/<spec>.*/d' $Jobconfigfile
sed -i '/<ignorePost.*/d' $Jobconfigfile
sed -i '/<\/hudson.trig.*/d' $Jobconfigfile

		fi
	done
}
$2
java -jar ${HOME}/jenkins-cli.jar -s http://172.31.10.238:8080 safe-restart --username sandeep.rawat --password sandy724
