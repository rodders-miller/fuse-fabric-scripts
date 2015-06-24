#!/bin/bash

#include the common commands, set version and wait for the fabric to be available
source common-commands.sh

echo $fusehome

rm -R -f "$fusehome/data"
mkdir "$fusehome/data"
rm -R -f "$fusehome/instances"
mkdir "$fusehome/instances"