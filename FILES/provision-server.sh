#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y isc-dhcp-server #The comand we used to install the dhcp sever
cat <<EOF | sudo tee /etc/dhcp/dhcpd.conf
default-lease-time 86400;
max-lease-time 691200;
authoritative; 

option domain-name "micasa.es.";    
option domain-name-servers 8.8.8.8, 4.4.4.4;

subnet 192.168.57.0 netmask 255.255.255.0 {
  range 192.168.57.25 192.168.57.50;
  option routers 192.168.57.10;
  option broadcast-address 192.168.57.255;
}

host c2 {
  hardware ethernet 08:00:27:ab:cd:ef;
  fixed-address 192.168.57.4;
  default-lease-time 3600;
  option domain-name-servers 1.1.1.1;
}
EOF
sudo bash -c 'echo "INTERFACESv4=\"eth2\"" > /etc/default/isc-dhcp-server'

sudo systemctl restart isc-dhcp-server
sudo systemctl enable isc-dhcp-server



# COMMAND EXPLANATION
# apt-get update -y                 = Updates the package list
# apt-get install isc-dhcp-server   = Installs the DHCP server package
# cat <<EOF ...                     = Writes the DHCP configuration file
# echo 'INTERFACESv4="eth2"'        = Defines the interface to listen on
# systemctl restart ...             = Restarts the DHCP service
# systemctl enable ...              = Ensures the service starts on boot
#