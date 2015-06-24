#!/bin/bash

#Set the fabric version removing here (reading from file)
source common-commands.sh
set-version
set-resoure-dir
set-data-dir
profilepath="/fabric/fabric/profiles/mq/broker/ssb/broker.ssb/broker.profile"

wait-for-available


echo "creating the broker profile in version 1.0 so hawtio picks up on MQ configuration"
#create the MQ configuration here
$ssh2Fabric "fabric:mq-create --group ssb-broker ssb-broker"

echo "create the fabric version and profile here"
#create the fabric version and do the override here
$ssh2Fabric "fabric:version-create --parent 1.0 $fabricversion"

echo "upload the profile via Git to the server"
# upload the profile via Git to the server

git-clone 
git-copy-resources-to-profile "$profilepath" "$resource_dir/properties/broker/."

# update the properties with the brokers data directory and memory settings
echo $datadir
propFile="$profilepath/org.fusesource.mq.fabric.server-ssb-broker.properties"
inject_value_into_property $propFile 'BROKER_DATA_DIR' $datadir
inject_value_into_property $propFile 'STORE_USAGE' '5 gb'
inject_value_into_property $propFile 'MEMORY_USAGE' '100 mb'
inject_value_into_property $propFile 'REPLICAS' '1'

# To avoid clashes on local machine, move the web port to 9091
inject_property_into_properties "$profilepath/org.ops4j.pax.web.properties" "org.osgi.service.http.port=9091"

git-push-to-fabric