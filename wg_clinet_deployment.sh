#!/bin/bash 

# Creating private and public key. 
pub_i=$(ip -br l | awk '$1 !~ "lo|vir|wl" { print $1}')
wg genkey | tee privatekey | wg pubkey > publickey
private=$(cat privatekey)
 
echo """[Interface]
PrivateKey=$private

# Client Private network ip 
Address=Client
SaveConfig=true

[Peer]

PublicKey= <Wireguard Server public key >

# Wireguard server:Wireguard Port 
EndPoint=192.168.126.128:51820

# configure all traffic to go through the vpn or half tunnel 
AllowedIPs=0.0.0.0/0 """ > /etc/wireguard/wg0.conf

# Start wireguard 
wg-quick up wg0 
