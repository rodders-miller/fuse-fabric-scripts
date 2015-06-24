#!/bin/bash

fusehome=$(<fuse-home.txt)
echo "Fuse home set to $fusehome"

# base command for accessing the fabric  
ssh2Fabric="$fusehome/bin/client -h localhost"
echo "Fuse cmd is $ssh2Fabric"

# set clone dir for git clone  
clonedir="/c/fuse-git-repo-clone"
echo "Fuse cmd is $clonedir"

set-version() {
	#create the fabric version removing the SNAPSHOT if present
	version=$(<version.txt)
	snapshot='-SNAPSHOT'
	fabricversion=${version%*-*}

	echo  "The version is ${version}"
	echo  "The fabric version is ${fabricversion}"
}

set-data-dir()  {
  datadir='c:/ssb/data'
}


set-resoure-dir() {
	workingdir=$(pwd)
	echo $(pwd)
	cd "../ssb-common/src/main/resources/"
	echo $(pwd)
	resource_dir=$(pwd)
	cd $workingdir;
}

wait-for-available() {
	wait-for-client;
	wait-for-fabric;
}

wait-for-client() {
	# wait for ssh server to be up, avoids "Connection reset by peer" errors
	while ! $ssh2Fabric "echo up" ; do sleep 1s; done;
}

wait-for-fabric() {
	echo "wait for the service to be ready before continuing"
	$ssh2Fabric "wait-for-service -t 300000 io.fabric8.api.BootstrapComplete"
	$ssh2Fabric "wait-for-service org.apache.karaf.features.FeaturesService"
}

createFeatures (){
	echo "Adding features"
	while read -r line || [[ -n $line ]]; do
		$ssh2Fabric ="fabric:profile-edit --features $line $1 $2"
	done < $3
}


git-clone()
{	
	clonedir="/c/fuse-git-repo-clone"
	rm -R -f $clonedir
	mkdir -p $clonedir
	cd "$clonedir"

	git clone --branch $fabricversion  http://admin:admin@localhost:8181/git/fabric
}
	
git-copy-resources-to-profile()
{
    echo "git-copy-resources-to-profile Values of $1 and $2"
	
	localprofile="$clonedir/$1"

	mkdir -p $localprofile

	# copy the system and the ssb properties here
	cp -R "$2/." $localprofile
}

git-push-to-fabric()
{
	cd "$clonedir/fabric"
	git add .
	git commit -m "common-commands.sh:git-push-to-fabric committing properties for version $fabricversion" 
	git push
}	

inject_value_into_property() {

  localfile="${clonedir}/${1}"

  sed -i -- "s-${2}-${3}-g" $localfile
}

inject_property_into_properties() {
	propFile="${clonedir}/${1}"
	touch $propFile
	echo "${2}" >>  $propFile
}