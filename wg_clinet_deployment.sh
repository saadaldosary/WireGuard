#!/bin/bash 

# Creating private and public key. 
pub_i=$(ip -br l | awk '$1 !~ "lo|vir|wl" { print $1}')
wg genkey | tee privatekey | wg pubkey > publickey
private=$(cat privatekey)

# Setting endpoint ip 
echo "Enter your ENDPOINT IP:Port e.g. 192.168.1.1:51820 "
echo
read endpoint_ip

# Assigning Wireguard public key
echo "Enter WireGuard public key: "
echo
read wgs_pubkey

echo """[Interface]
PrivateKey=$private

# Client Private network ip 
Address=Client
SaveConfig=true

[Peer]

PublicKey= $wgs_pubkey

# Wireguard server:Wireguard Port 
EndPoint= $endpoint_ip

# configure all traffic to go through the vpn or half tunnel 
AllowedIPs=0.0.0.0/0 """ > /etc/wireguard/wg0.conf

# Start wireguard 
wg-quick up wg0 
