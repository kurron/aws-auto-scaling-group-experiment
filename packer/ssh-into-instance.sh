#!/bin/bash

IP=$1
CMD="ssh -v -i ../auto-scaling-experiments.pem ubuntu@${IP}"
echo $CMD
$CMD
