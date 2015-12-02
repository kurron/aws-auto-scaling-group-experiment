#!/bin/bash

IP=$1
ssh -v -i ../open-vpn.pem ubuntu@${IP}
