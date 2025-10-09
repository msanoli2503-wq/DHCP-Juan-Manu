# DHCP Server Configuration  

## 1. Virtual Machine Creations
1. By using vagrant we created and configure  the three virtual machines,using the box debian/bullseye64 and also we create a provision file for each type of machine (Clients an Server).

---

## Step 2: Server Configuration (Vagrant + Provision)
1.This was automated in [provision-server.sh](https://github.com/msanoli2503-wq/DHCP-Juan-Manu/blob/main/FILES/provision-server.sh)

---

## Step 3: Network Verification on Server

2. Two network adapters were configured([In the Vagrantfile](https://github.com/msanoli2503-wq/DHCP-Juan-Manu/blob/main/FILES/Vagrantfile))

    
    Adapter 1: Host-only network 192.168.56.0/24 with IP 192.168.56.10(For the communication between The real PC and the Machine)
    Adapter 2: Internal network 192.168.57.0/24 with IP 192.168.57.10(For the comunication between the machines )

    The first adapter had Internet access to download packages; the second was used for DHCP traffic only.

    The network configuration was verified with the command: **ip a** . 
    **OUT PUT**:
        
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000 NAT
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
        
    **NAT NETWORK(INTERNET SOURCE)**

    2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000 
    link/ether 08:00:27:8d:c0:4d brd ff:ff:ff:ff:ff:ff
    altname enp0s3
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 86128sec preferred_lft 86128sec
    inet6 fd17:625c:f037:2:a00:27ff:fe8d:c04d/64 scope global dynamic mngtmpaddr 
       valid_lft 86128sec preferred_lft 14128sec
    inet6 fe80::a00:27ff:fe8d:c04d/64 scope link 
       valid_lft forever preferred_lft forever

    **HOST-ONLY INTERFACE**

    3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:9b:fc:65 brd ff:ff:ff:ff:ff:ff
    altname enp0s8
    inet 192.168.56.10/24 brd 192.168.56.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe9b:fc65/64 scope link 
       valid_lft forever preferred_lft forever

    **INTERNAL NETWORK FOR DHCP**

    4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:70:2f:7c brd ff:ff:ff:ff:ff:ff
    altname enp0s9
    inet 192.168.57.10/24 brd 192.168.57.255 scope global eth2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe70:2f7c/64 scope link 
       valid_lft forever preferred_lft forever

---
## Step 4: Client 1 (c1) – DHCP Dynamic Address

Once again we  automated this with [provision-c1.sh](https://github.com/msanoli2503-wq/DHCP-Juan-Manu/blob/main/FILES/provision-c1.sh)....