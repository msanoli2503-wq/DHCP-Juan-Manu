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

#COMMAND EXPLANATION
# apt-get update -y                 → Updates the package list
# apt-get install isc-dhcp-client   → Installs the DHCP client package
# tee /etc/network/interfaces       → Configures eth1 to get IP via DHCP
# systemctl restart networking      → Applies the new network settings
# dhclient -v eth1                  → Requests the fixed IP based on MAC