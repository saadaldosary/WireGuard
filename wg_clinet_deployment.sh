#!/bin/bash 

pub_i=$(ip -br l | awk '$1 !~ "lo|vir|wl" { print $1}')
wg genkey | tee privatekey | wg pubkey > publickey
private=$(cat privatekey)
 
echo """[Interface]
PrivateKey=$private
Address=192.168.1.1/24
SaveConfig=true

[Peer]
PublicKey=p5CHpnUVHV5c61Vp2Ge58s1DxHl695PL+70dvPz/+20=
EndPoint=192.168.126.128:51820
# configure all traffic to go through the vpn or half tunnel 
AllowedIPs=0.0.0.0/0 """ > /etc/wireguard/wg0.conf

wg-quick up wg0 
