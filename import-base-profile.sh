#!/bin/bash

#Set the fabric version removing here (reading from file)
source common-commands.sh
set-version
set-resoure-dir
profilepath="/fabric/fabric/profiles/ssb/base/profile.profile"

wait-for-available

echo "create the fabric version and profile here"
#create the fabric version and do the override here
$ssh2Fabric "fabric:version-create --parent 1.0 $fabricversion"

echo "create the fabric profile"
#create profile here in version 
$ssh2Fabric "fabric:profile-create --version $fabricversion ssb--base-profile"

echo "upload the profile via Git to the server"
# upload the profile via Git to the server

git-clone 
git-copy-resources-to-profile "$profilepath" "$resource_dir/properties/system/."
git-push-to-fabric