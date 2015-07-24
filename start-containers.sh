#!/bin/bash

#Set the fabric version removing here (reading from file)
source common-commands.sh

wait-for-available

echo "start containers"

$ssh2Fabric "fabric:container-start --jmx-password admin ssb"
$ssh2Fabric "fabric:container-start --jmx-password admin ssb-broker"