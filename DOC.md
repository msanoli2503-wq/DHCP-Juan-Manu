# DHCP Server Configuration  

## 1. Virtual Machine Creations
1. By using vagrant we created and configure  the three virtual machines,using the box debian/bullseye64 and also we create a provision file for each type of machine (Clients an Server).

---

## Step 2: Server Configuration (Vagrant + Provision)
This was automated in [provision-server.sh](https://github.com/msanoli2503-wq/DHCP-Juan-Manu/blob/main/FILES/provision-server.sh)

1. Installs the DHCP server.

2. Defines the IP range: 192.168.57.25 to 192.168.57.50.

3. Configures a static lease for c2 (MAC 08:00:27:ab:cd:ef) with IP 192.168.57.4.

4. Configures the service to listen on eth2.

5. Starts and enables the service automatically.

---

## Step 3: Network Verification on Server

2. Two network adapters were configured[In the Vagrantfile](https://github.com/msanoli2503-wq/DHCP-Juan-Manu/blob/main/FILES/Vagrantfile),also there you can see the structure we followed and the explanation for the commands 

    
    **Adapter 1**: Host-only network 192.168.56.0/24 with IP 192.168.56.10(For the communication between The real PC and the Machine).

    **Adapter 2**: Internal network 192.168.57.0/24 with IP 192.168.57.10(For the comunication between the machines ).

   The first adapter had Internet access to download packages; the second was used for DHCP traffic only.
   
   The network configuration was verified with the command: **ip a** . 
    
    **OUT PUT**:
    ----    
   **LOOPBACK**

    1. lo: **<LOOPBACK,UP,LOWER_UP>** mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000 NAT
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
        
    **NAT NETWORK(INTERNET SOURCE)**

    2. eth0: **<BROADCAST,MULTICAST,UP,LOWER_UP>** mtu 1500 qdisc pfifo_fast state UP group default qlen 1000 
    link/ether 08:00:27:8d:c0:4d brd ff:ff:ff:ff:ff:ff
    altname enp0s3
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 86128sec preferred_lft 86128sec
    inet6 fd17:625c:f037:2:a00:27ff:fe8d:c04d/64 scope global dynamic mngtmpaddr 
       valid_lft 86128sec preferred_lft 14128sec
    inet6 fe80::a00:27ff:fe8d:c04d/64 scope link 
       valid_lft forever preferred_lft forever

    **HOST-ONLY INTERFACE**

    3. eth1: **<BROADCAST,MULTICAST,UP,LOWER_UP>** mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:9b:fc:65 brd ff:ff:ff:ff:ff:ff
    altname enp0s8
    inet 192.168.56.10/24 brd 192.168.56.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe9b:fc65/64 scope link 
       valid_lft forever preferred_lft forever

    **INTERNAL NETWORK FOR DHCP**

    4. eth2: **<BROADCAST,MULTICAST,UP,LOWER_UP>** mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:70:2f:7c brd ff:ff:ff:ff:ff:ff
    altname enp0s9
    inet 192.168.57.10/24 brd 192.168.57.255 scope global eth2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe70:2f7c/64 scope link 
       valid_lft forever preferred_lft forever

---

## Step 4: Client 1 (c1) – Fixed IP via MAC

Once again we automated this with [provision-c1.sh](https://github.com/msanoli2503-wq/DHCP-Juan-Manu/blob/main/FILES/provision-c1.sh),also there you'll find more info about the commands.

-Thanks to the provision c1 requests an IP from the DHCP server through eth1 and It receives an address between **192.168.57.25** and **192.168.57.50**.

-If you want it you could check it with the  **ip** command once more to see the results. 

---

## STEP 5 Client 2 (c2)-Fixed ip via MAC
We configured this with the static lease in the server’s dhcpd.conf and [provision-c2.sh](https://github.com/msanoli2503-wq/DHCP-Juan-Manu/blob/main/FILES/provision-c2.sh),also there you'll find more info about the commands.

1.  The c2 uses DHCP, but the server recognizes its MAC and always gives: **192.168.57.4**.

---

## Step 6 Log and Lease Verification

On the server by using this command:**sudo cat /var/log/syslog | grep dhcpd**.

And we get an **output** like this:

DHCPDISCOVER from **08:00:27:ab:cd:ef**.
DHCPOFFER on **192.168.57.4**.
DHCPREQUEST for **192.168.57.4**.
DHCPACK on **192.168.57.4**.

---

And to see the **lease file** we use this command :**cat /var/lib/dhcp/dhcpd.leases**

And again we get an **output** similar to this:

lease **192.168.57.4** {
  **starts** 2 2025/10/08 14:25:30;
  **ends** 2 2025/10/08 15:25:30;
  binding state **active**;
  hardware ethernet **08:00:27:ab:cd:ef**;
  client-hostname **"c2"**;
}

But also while we are installing the machines we can see in the console. 

---

## Step 7 Releasing and Renewing IP

You can test **DHCP behavior** by releasing and renewing:

1. **sudo dhclient -r eth1**.
2. **sudo dhclient eth1**.

c1 = receives a **new dynamic IP**.

c2 = always gets **192.168.57.4**.





