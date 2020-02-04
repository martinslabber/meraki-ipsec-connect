meraki-ipsec-connect
====================
Script to help with ipsec/l2tp connection, for use with Cisco Meraki devices.

Setup
-----

Install strongswan and xl2tpd.
Create the files username, password, and hostname in ~/.config/meraki-vpn/default
these files should contain your username, password and the Meraki hostname that you connect to.
Create a file routes in that directory that contain the CIDRs that are routed via the VPN. One per line.

::

        apt-get install -y strongswan xl2tpd
        mkdir -p ~/.config/meraki-vpn/default
        echo "martinslabber" > ~/.config/meraki-vpn/default/username
        echo "s3cr3t" > ~/.config/meraki-vpn/default/password
        echo "example-wapqikrk2z.dynamic-m.com" > ~/.config/meraki-vpn/default/hostname
        echo "192.168.34.0/24" > ~/.config/meraki-vpn/default/routes

The shared connection secret is also stored in the directory ~/.config/meraki-vpn/default.
This secret is stored in the file named ipsec.secret and should have the following format.
Replace AAAA with the shared secret. Keep the "'s.

::

         : PSK "AAAA"

Based on
https://gist.github.com/psanford/42c550a1a6ad3cb70b13e4aaa94ddb1c
