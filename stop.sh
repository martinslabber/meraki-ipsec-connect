#!/bin/bash

sudo sh -c 'echo "d meraki-vpn" > /var/run/xl2tpd/l2tp-control'
sudo ipsec down meraki-vpn
sudo systemctl stop strongswan
sudo systemctl stop xl2tpd
