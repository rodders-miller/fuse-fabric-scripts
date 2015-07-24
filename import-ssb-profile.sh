#!/bin/bash

#Set the fabric version removing here (reading from file)
source common-commands.sh
set-version
set-version
set-resoure-dir
profilepath="/fabric/fabric/profiles/ssb/profile.profile"

#
# Allow different features txt to be used
#

featurestxt="$resource_dir/deploy/features.txt"

if [ "x$1" = "x" ]; then
	featurestxt="$1"
fi

wait-for-available

echo "create the fabric version and profile here"
#create the fabric version and do the override here
$ssh2Fabric "fabric:version-create --parent 1.0 $fabricversion"

echo "create the fabric profile"
#create profile here in version 
$ssh2Fabric "fabric:profile-create --version $fabricversion --parents jboss-fuse-minimal --parents ssb-base-profile ssb-profile"

echo "upload the profile via Git to the server"
# upload the profile via Git to the server

git-clone 
git-copy-resources-to-profile "$profilepath" "$resource_dir/properties/ssb/."
#git-copy-resources-to-profile "$profile-path" "$resource_dir/properties/system/."
git-push-to-fabric

# add repo and overide here - TODO,  add these to the fabric agent properties via git
$ssh2Fabric "fabric:profile-edit --repositories mvn:gov.uk.homeoffice.ssb/ssb-core-features/$version/xml/features ssb-profile $fabricversion"
$ssh2Fabric "fabric:profile-edit --pid io.fabric8.agent/override.mvn:org.apache.servicemix.bundles/org.apache.servicemix.bundles.jaxb-impl/2.2.1.1_2=mvn:org.apache.servicemix.bundles/org.apache.servicemix.bundles.jaxb-impl/2.2.10_1 ssb-profile $fabricversion"

createFeatures "ssb-profile" $fabricversion "$resource_dir/deploy/features.txt"
