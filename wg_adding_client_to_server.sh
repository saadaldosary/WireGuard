#!/bin/bash

echo 'Enter client public key..'
read cpublic

echo 'Enter client IP address..'
read cIP 

wg set wg0 peer $cpublic allowed-ips $cIP/32  
