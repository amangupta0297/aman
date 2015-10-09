#!/bin/bash

source ${HOME}/scripts/os_functions.sh

#I'll create the storing directory for releases under  /var/release/${project}_${app_identifier}_${env_identifier}
function getSaveReleasePath(){
        PROJECT_ID=$1
        APP_ID=$2
        ENV_ID=$3

	saveReleasePath=`getReleasePath ${PROJECT_ID} ${APP_ID} ${ENV_ID}`
        mkdir -p ${saveReleasePath}
        echo "${saveReleasePath}"
}

function getReleasePath(){
        PROJECT_ID=$1
        APP_ID=$2
        ENV_ID=$3

        releasePath="/var/release/${PROJECT_ID}/${APP_ID}/${ENV_ID}"
        echo "${releasePath}"

}
#I'll save the file identified by ARCHIVE_PATH at release/${PROJECT_ID}/${APP_ID}/${ENV_ID}/${RELEASE_ID}
function saveRelease() {
	PROJECT_ID=$1
	APP_ID=$2
	ENV_ID=$3
	RELEASE_ID=$4
	ARCHIVE_PATH=$5

        saveReleasePath=`getSaveReleasePath ${PROJECT_ID} ${APP_ID} ${ENV_ID}`
        echo "Copying release version ${RELEASE_ID}..."
        cp ${ARCHIVE_PATH} ${saveReleasePath}/${RELEASE_ID}

}


#I'll list the available releases for an app of a  project for a specified environment
function listReleases() {
        PROJECT_ID=$1
        APP_ID=$2
        ENV_ID=$3

        saveReleasePath=`getSaveReleasePath ${PROJECT_ID} ${APP_ID} ${ENV_ID}`

        listFilesNamesInDirectory ${saveReleasePath}
}


#I'll delete a release for an app of a  project for a specified environmen
function deleteRelease(){
        PROJECT_ID=$1
        APP_ID=$2
        ENV_ID=$3
        RELEASE_ID=$4

        saveReleasePath=`getSaveReleasePath ${PROJECT_ID} ${APP_ID} ${ENV_ID}`

        if [ -f "${saveReleasePath}/${RELEASE_ID}" ]
        then 
                echo "Removing version ${RELEASE_ID} from ${saveReleasePath}"
                rm -rf ${saveReleasePath}/${RELEASE_ID}
                return 0
        else 
                echo "Version ${RELEASE_ID} not available"
                return 1
        fi    

}

#I'll get a release for an app of a  project for a specified environment at the asked location	
function getReleasedVersion() {
        PROJECT_ID=$1
        APP_ID=$2
        ENV_ID=$3
        RELEASE_ID=$4
        ARCHIVE_PATH=$5

        saveReleasePath=`getSaveReleasePath ${PROJECT_ID} ${APP_ID} ${ENV_ID}`

        if [ -f "${saveReleasePath}/${RELEASE_ID}" ]
        then 
                echo "Copying version ${RELEASE_ID} from ${saveReleasePath} to ${ARCHIVE_PATH}"
                cp ${saveReleasePath}/${RELEASE_ID} ${ARCHIVE_PATH}
                return 0
        else 
                echo "Version ${RELEASE_ID} not available"
                return 1
        fi
}

function migrateReleaseFromSourceToDestination() {
PROJECT_ID=$1
APP_ID=$2
RELEASE_ID=$3
SRC_ENV=$4
DST_ENV=$5

sourceFolderPath=`getReleasePath ${PROJECT_ID} ${APP_ID} ${SRC_ENV}`
destinationFolderPath=`getSaveReleasePath ${PROJECT_ID} ${APP_ID} ${DST_ENV}`



if [ -d "${sourceFolderPath}" ];
then
	echo "Source path available as ${sourceFolderPath} now looking for version ${RELEASE_ID}"
	if [ -f "${sourceFolderPath}/${RELEASE_ID}" ]
		then 
		echo "copying release from source to destination"
		cp ${sourceFolderPath}/${RELEASE_ID} ${destinationFolderPath}
		return 0   
	else 
	       echo "Version ${RELEASE_ID} not available"
	       return 1
	fi
else
	echo "Source folder path ${sourceFolderPath} does not exist"
	return 1
fi   
}
   



