#!/bin/bash

echo "########### Installation of Ansible"
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt install ansible-core -y

echo "############ Git Clone"
git clone https://github.com/awshift/awshift-tf.git
cd awshift-tf

git fetch origin
git checkout -b dev origin/dev
