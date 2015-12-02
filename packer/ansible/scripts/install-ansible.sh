#!/bin/bash

sudo --set-home easy_install pip
sudo --set-home install ansible

# this form can't seem to get access to all the packages and fails with 404 sometimes
#sudo apt-get install -y build-essential dkms python-setuptools python-dev
#curl -O https://bootstrap.pypa.io/get-pip.py
#sudo --set-home python get-pip.py
#sudo --set-home pip install ansible 

# this form was the only one that works in AWS
#sudo apt-get install -y software-properties-common
#sudo apt-add-repository -y ppa:ansible/ansible
#sudo apt-get -y update
#sudo apt-get install -y ansible
