#!/bin/bash
source ~/.profile

rm -rf node_modules
npm cache clean
npm install 

if [ $? != 0 ]
then
    echo "Build failed due to npm failed"
    exit 1
fi

bower install -y 

if [ $? != 0 ]
then
     echo "Build failed due to Bower failed"
     exit 1
fi

gulp build:dist
