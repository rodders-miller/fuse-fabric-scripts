#!/bin/bash

MESSAGE_TO_SEND="send"
BASE_JOLIKIA_EXEC_ADDR="http://localhost:8181/jolokia/exec"

#curl --user admin:admin -G -v "$BASE_JOLIKIA_EXEC_ADDR/org.apache.activemq:type=Broker,brokerName=root,destinationType=Queue,destinationName=test/sendTextMessage(java.lang.String,java.lang.String,java.lang.String)/$MESSAGE_TO_SEND/admin/admin"


BASE_JOLIKIA_POST_ADDR="http://localhost:8182/jolokia/"
MESSAGE_TO_POST='{"type":"exec","mbean":"org.apache.activemq:type=Broker,brokerName=root,destinationType=Queue,destinationName=test","operation":"sendTextMessage(java.lang.String,java.lang.String,java.lang.String)","arguments":["message","admin","admin"]}'

#curl --user admin:admin $BASE_JOLIKIA_POST_ADDR -v -XPOST -d $MESSAGE_TO_POST 

#curl --user admin:admin $BASE_JOLIKIA_POST_ADDR -v -XPOST -d '{"type":"exec","mbean":"org.apache.activemq:type=Broker,brokerName=root,destinationType=Queue,destinationName=test","operation":"sendTextMessage(java.lang.String,java.lang.String,java.lang.String)",,"arguments":["message","admin","admin"]}' 

MESSAGE_TO_POST='{"type":"exec","mbean":"org.apache.camel:context=org.jboss.quickstarts.fuse.eip,type=routes,name=\"filterRoute\"","operation":"stop()"}'

curl --user admin:admin $BASE_JOLIKIA_POST_ADDR -v -XPOST -d $MESSAGE_TO_POST 

MESSAGE_TO_POST='{"type":"exec","mbean":"io.fabric8:type=Fabric","operation":"fabricStatus()"}'

curl --user admin:admin $BASE_JOLIKIA_POST_ADDR -v -XPOST -d $MESSAGE_TO_POST 