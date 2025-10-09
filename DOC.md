# DHCP Server Configuration  

## 1. Virtual Machine Creations
1. By using vagrant we created and configure  the three virtual machines,using the box debian/bullseye64 and also we create a provision file for each type of machine (Clients an Server).

---

## 2. Linux Server Configuration
1. By using vagrant one of the Linux virtual machine we created was used as the DHCP server.
Initially, the DHCP service was not installed( as I said later we used a provision file).

2. Two network adapters were configured(In the Vagrantfile)
    Adapter 1: Host-only network 192.168.56.0/24 with IP 192.168.56.10(For the communication between The real PC and the Machine)
    Adapter 2: Internal network 192.168.57.0/24 with IP 192.168.57.10(For the comunication between the machines )

    The first adapter had Internet access to download packages; the second was used for DHCP traffic only.

    The network configuration was verified with the command: **ip a** . 

---