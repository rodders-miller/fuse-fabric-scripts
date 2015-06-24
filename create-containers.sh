#!/bin/bash

#Set the fabric version removing here (reading from file)
source common-commands.sh

#Set the version of the fabric
set-version

wait-for-available

echo "create containers"
#create containers
$ssh2Fabric "fabric:container-create-child --version $fabricversion --profile ssb-profile --jmx-password admin root ssb"
$ssh2Fabric "fabric:container-create-child --version $fabricversion --profile mq-broker-ssb-broker.ssb-broker --jmx-password admin root ssb-broker"