#! /bin/bash

# Target VPN server, username, and password are kept in files.
export VPNHOST=$(cat ~/.config/meraki-vpn/default/hostname)
export USERNAME=$(cat ~/.config/meraki-vpn/default/username)
export PASSWORD=$(cat ~/.config/meraki-vpn/default/password)

mkdir -p /tmp/ipsec
envsubst < ipsec.conf > /tmp/ipsec/ipsec.conf
envsubst < xl2tpd.conf > /tmp/ipsec/xl2tpd.conf
envsubst <  options.l2tpd.client > /tmp/ipsec/options.l2tpd.client

sudo cp ~/.config/meraki-vpn/default/ipsec.secrets /etc/ipsec.secrets
sudo cp /tmp/ipsec/ipsec.conf /etc/ipsec.conf
sudo cp /tmp/ipsec/xl2tpd.conf /etc/xl2tpd/xl2tpd.conf
sudo cp /tmp/ipsec/options.l2tpd.client /etc/ppp/options.l2tpd.client
sudo mkdir -p /var/run/xl2tpd
sudo touch /var/run/xl2tpd/l2tp-control
sudo systemctl restart strongswan
sudo systemctl restart xl2tpd
sleep 1
sudo ipsec up meraki-vpn
sudo sh -c 'echo "c meraki-vpn" > /var/run/xl2tpd/l2tp-control'
sleep 2 # Wait for the device to be created.
for n in $(seq 4); do ifconfig ppp0; res=$?; if [ $res -ne 0 ]; then  sleep 1; else break; fi; done
sleep 4

for ROUTE in $(cat ~/.config/meraki-vpn/default/routes | grep -v "^#")
    do
    sudo ip route add $ROUTE dev ppp0
    done
rm -rf /tmp/ipsec
