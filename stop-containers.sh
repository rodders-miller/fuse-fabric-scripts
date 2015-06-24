#!/bin/bash

#Set the fabric version removing here (reading from file)
source common-commands.sh

#Set the version of the fabric
set-version

wait-for-available

echo "stop containers"
#deletes containers
$ssh2Fabric "fabric:container-stop ssb"
$ssh2Fabric "fabric:container-stop ssb-broker"
$ssh2Fabric "exit"