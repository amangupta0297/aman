#!/bin/bash


function listFilesNamesInDirectory(){
	
	absolutePathOflistFilesNamesInDirectory=$1
	
	for file in ${absolutePathOflistFilesNamesInDirectory}/*
	do
	    if [[ -f ${file} ]]; then
	        echo "${file}" |awk '{gsub("'/var/release/'", "");print}'
	    fi
	done
}
