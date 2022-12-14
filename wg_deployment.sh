#!/bin/bash 

pub_i=$(ip -br l | awk '$1 !~ "lo|vir|wl" { print $1}')
wg genkey | tee privatekey | wg pubkey > publickey
private=$(cat privatekey)

echo """
[Interface]
PrivateKey=$private
Address=192.168.1.1/24
SaveConfig=true
PostUp=iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o $pub_i  -j MASQUERADE;
PostUp=iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o $pub_i  -j MASQUERADE;
ListenPort = 51820
""" > /etc/wireguard/wg0
