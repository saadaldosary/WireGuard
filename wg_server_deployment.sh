#!/bin/bash 

# Generating public and private keys 
pub_i=$(ip -br l | awk '$1 !~ "lo|vir|wl" { print $1}')
wg genkey | tee privatekey | wg pubkey > publickey
private=$(cat privatekey)

echo """[Interface]
PrivateKey=$private
Address= <your private network ip>
SaveConfig=true
PostUp=iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o $pub_i  -j MASQUERADE;
PostDown=iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o $pub_i  -j MASQUERADE;
ListenPort = 51820
""" > /etc/wireguard/wg0.conf
# Start WireGuard
wg-quick up wg0
