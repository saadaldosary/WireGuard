#!/bin/bash

echo "################## Updating OS"
yum update -y 
echo "################## Installing WireGuard"
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm -y 
sudo yum install kmod-wireguard wireguard-tools -y 
echo "#####################################################"
echo "Installtion completed, Please reboot your machine"
