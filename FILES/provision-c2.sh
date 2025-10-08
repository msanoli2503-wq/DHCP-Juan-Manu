#!/bin/bash
set -e

sudo apt-get update -y
sudo apt-get install -y isc-dhcp-client

sudo tee /etc/network/interfaces > /dev/null <<EOF
auto lo
iface lo inet loopback

auto eth1
iface eth1 inet dhcp
EOF

sudo systemctl restart networking || true
sudo dhclient -v eth1 || true
