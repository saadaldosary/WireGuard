#!/bin/bash

echo "Installation started.."
echo 
echo "#####################################################"
yum update -y 
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm -y 
sudo yum install kmod-wireguard wireguard-tools -y 
echo 
echo "#####################################################"
echo "installtion completed"
