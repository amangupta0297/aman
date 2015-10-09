#!/bin/bash

releaseIdentifier=$1
absoluteWarLocation=$2
mkdir -p /release/$releaseIdentifier

cp $absoluteWarLocation /release/$releaseIdentifier/

