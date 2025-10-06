# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
end


config.vm.define "server" do |server|
    server.vm.box = "debian/bookworm64"
    server.vm.hostname = "server"
    server.vm.network "private_network", ip: "192.168.56.10"
    server.vm.network "private_network", ip: "192.168.57.10"
  end

  # Client 1 (c1)
  config.vm.define "c1" do |c1|
    c1.vm.box = "debian/bookworm64"
    c1.vm.hostname = "c1"
    c1.vm.network "private_network", type: "dhcp"
  end

  # Client 2 (c2)
  config.vm.define "c2" do |c2|
    c2.vm.box = "debian/bookworm64"
    c2.vm.hostname = "c2"
    c2.vm.network "private_network", type: "dhcp"
  end
end