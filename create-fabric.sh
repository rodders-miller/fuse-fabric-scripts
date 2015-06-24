#!/bin/bash

#include the common commands, set version and wait for the fabric to be available
source common-commands.sh

# wait for the container to be ready
wait-for-available

echo "create the fabric" 
$ssh2Fabric "fabric:create --profile fabric --global-resolver localhostname --zookeeper-password admin --wait-for-provisioning"

# Set the local maven repo URL so local builds available to the fabric
$localMaven='C:/Users/rodm/.m2/repository'
$ssh2Fabric "profile-edit --append --pid io.fabric8.agent/org.ops4j.pax.url.mvn.defaultRepositories=${localMaven} default"