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

# set -e = Makes the script exit immediately if any command fails.

# sudo apt-get update -y = Updates the system's package index to get the latest list of packages.

# sudo apt-get install -y isc-dhcp-server = Installs the ISC DHCP server package without asking for confirmation (-y).

# cat <<EOF | sudo tee /etc/dhcp/dhcpd.conf = Creates the DHCP server configuration file by redirecting the content between EOF markers.

# default-lease-time 86400; = Sets the default lease time for dynamic IPs to 86,400 seconds (1 day).

# max-lease-time 691200; =Sets the maximum lease time to 691,200 seconds (8 days).

# authoritative; = Tells the DHCP server it is the authoritative server for this network.

# option domain-name "micasa.es.";  = Specifies the domain name for clients receiving IP addresses.

# option domain-name-servers 8.8.8.8, 4.4.4.4; = Defines which DNS servers will be provided to DHCP clients.

# subnet 192.168.57.0 netmask 255.255.255.0 { = Defines the subnet and its netmask where IPs will be leased.

# range 192.168.57.25 192.168.57.50; = IP range the DHCP server will use to assign dynamic addresses.

# option routers 192.168.57.10; = Default gateway that clients will use.

# option broadcast-address 192.168.57.255; = Broadcast address for the subnet.

# host c2 { ... } = Defines a fixed IP configuration for a specific client based on MAC address.

# hardware ethernet 08:00:27:ab:cd:ef; = The MAC address of the client that should get the fixed IP.

# fixed-address 192.168.57.4; = The IP address that will be assigned to that client.

# default-lease-time 3600 = Sets the lease time for this static IP to 3600 seconds (1 hour).

# option domain-name-servers 1.1.1.1; = DNS server specifically for this client.

# echo 'INTERFACESv4="eth2"' | sudo tee /etc/default/isc-dhcp-server = Tells the DHCP server to listen on eth2 (the internal network interface).

# sudo systemctl restart isc-dhcp-server = Restarts the DHCP service to apply the new configuration.

# sudo systemctl enable isc-dhcp-server = Enables the DHCP service to start automatically on boot.