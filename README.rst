meraki-ipsec-connect
====================
Script to help with ipsec/l2tp connection, for use with Cisco Meraki devices.

Setup
-----

Install strongswan and xl2tpd.
Create the files username, password, and hostname in ~/.config/meraki-vpn/default
these files should contain your username, password and the Meraki hostname that you connect to.
::
        apt-get install -y strongswan xl2tpd
        mkdir -p ~/.config/meraki-vpn/default
        echo "martinslabber" > ~/.config/meraki-vpn/default/username
        echo "s3cr3t" > ~/.config/meraki-vpn/default/password
        echo "sansa-gwgqgktkzz.dynamic-m.com
        echo "example-wapqikrk2z.dynamic-m.com" > ~/.config/meraki-vp

Based on
https://gist.github.com/psanford/42c550a1a6ad3cb70b13e4aaa94ddb1c
