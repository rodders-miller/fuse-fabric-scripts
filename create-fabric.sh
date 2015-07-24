#!/bin/bash

#include the common commands, set version and wait for the fabric to be available
source common-commands.sh

# wait for the container to be ready
wait-for-available

echo "create the fabric" 
$ssh2Fabric "fabric:create --profile fabric --global-resolver localhostname --zookeeper-password admin --wait-for-provisioning"

wait-for-available

# Set the local maven repo URL so local builds available to the fabric
localMaven=$(<local-maven.txt)
$ssh2Fabric "profile-edit --append --pid io.fabric8.agent/org.ops4j.pax.url.mvn.defaultRepositories=${localMaven} default"
$ssh2Fabric "profile-edit --bundles mvn:gov.uk.homeoffice.ssb/shared-service-bus/1.0.1458-SNAPSHOT default"