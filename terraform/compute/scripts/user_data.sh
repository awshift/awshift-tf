#!/bin/bash

## Step 1
# Set Users & Groups
# Update the system
sudo yum update -y || sudo apt-get update -y && sudo apt-get upgrade -y

# Disabling Firewalld
systemctl stop firewalld
systemctl disable firewalld

# Install the necessary packages

# Create the necessary directories
mkdir -p /opt/okd/
mkdir -p /opt/okd/manifests_bak
mkdir -p /opt/okd/install_config_bak
mkdir -p /opt/okd/install_dir


# Get openshift-install and oc
# Openshift Install
curl https://github.com/okd-project/okd/releases/download/4.14.0-0.okd-2024-01-26-175629/openshift-install-linux-4.14.0-0.okd-2024-01-26-175629.tar.gz && tar -xvf openshift-install-linux-4.14.0-0.okd-2024-01-26-175629.tar.gz
mv openshift-install /opt/okd/


# Openshift Client
wget https://github.com/okd-project/okd/releases/download/4.14.0-0.okd-2024-01-26-175629/openshift-client-linux-4.14.0-0.okd-2024-01-26-175629.tar.gz && tar -xvf openshift-client-linux-4.14.0-0.okd-2024-01-26-175629.tar.gz
mv oc /usr/local/bin/
mv kubectl /usr/local/bin/

oc version || echo "oc ain't working"
kubectl version || echo "kubectl ain't working"



# Tear down 
rm -rf openshift-install-linux-4.14.0-0.okd-2024-01-26-175629.tar.gz
rm -rf openshift-client-linux-4.14.0-0.okd-2024-01-26-175629.tar.gz


## Step 2

