# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/rocky9"
  config.ssh.insert_key = false

  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = "2048"
    libvirt.cpus = 2
  end

  boxes = [
      { :name => "workstation", :ip => "172.25.250.9" },
      { :name => "servera", :ip => "172.25.250.10" },
      { :name => "serverb", :ip => "172.25.250.11" },
  ]

  boxes.length.times do |i|
    opts = boxes[i]
    config.vm.define opts[:name] do |config|
      config.vm.hostname = "#{opts[:name]}.mydomain.com"
      config.vm.network :private_network, ip: opts[:ip]

      if ENV['HOST'] == opts[:name]
        config.vm.provider :libvirt do |libvirt|
         libvirt.storage :file, :size => ENV['SIZE'] ? ENV['SIZE'] : '5G'
        end
      end

      if i == (boxes.length-1)
        config.vm.provision "ansible" do |ansible|
          ansible.playbook = "./playbooks/provision.yml"
          ansible.inventory_path = "./playbooks/inventory"
          ansible.limit = "all"
        end
      end

    end
  end

  if ARGV[0] == "ssh"
    config.ssh.username = 'student'
  end

end
