#!/bin/bash

#Set the fabric version removing here (reading from file)
source common-commands.sh

#Set the version of the fabric
set-version

wait-for-available

echo "create containers"
#deletes containers
$ssh2Fabric "fabric:container-delete ssb"
$ssh2Fabric "fabric:container-delete ssb-broker"