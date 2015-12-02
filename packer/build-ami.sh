#!/bin/bash

export PACKER_LOG=activate
#export PACKER_LOG_PATH=/tmp

packer validate us-east-1.json 
packer build us-east-1.json 
