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

# set -e = Exits immediately if any command fails.

# sudo apt-get update -y = Updates the package list to ensure we have the latest info.

# sudo apt-get install -y isc-dhcp-client =  Installs the ISC DHCP client package.

# sudo tee /etc/network/interfaces > /dev/null <<EOF = Overwrites the network interfaces configuration file with the content between EOF.

# auto lo = Ensures the loopback interface is enabled automatically at boot.

# iface lo inet loopback = Configures the loopback interface with the loopback method.

# auto eth1 = Brings up interface eth1 automatically at boot.

# iface eth1 inet dhcp
#  Configures eth1 to obtain its IP address via DHCP (fixed IP will be given based on MAC address).

# sudo systemctl restart networking || true =  Restarts the networking service to apply the changes. “|| true” prevents failure if the command has harmless warnings.

# sudo dhclient -v eth1 || true = Requests the IP address from the DHCP server. In this case, the server gives the fixed IP configured for this MAC address.