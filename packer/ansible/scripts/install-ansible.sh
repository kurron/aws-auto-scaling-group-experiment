#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y build-essential dkms linux-headers-$(uname -r) python-setuptools python-dev
sudo easy_install pip
sudo --set-home pip install ansible
