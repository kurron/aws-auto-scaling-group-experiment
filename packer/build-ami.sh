#!/bin/bash

export PACKER_LOG=activate
#export PACKER_LOG_PATH=/tmp

packer validate us-west-2.json 
packer build us-west-2.json 
