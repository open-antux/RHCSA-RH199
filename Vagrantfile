Vagrant.configure("2") do |config|

  config.vm.box = "generic/rocky9"
  #config.vm.synced_folder = ".", "/vagrant", disabled: true
  config.ssh.insert_key = false

  config.vm.provider :virtualbox do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.linked_clone = true
  end

  boxes = [
    { :name => "workstation", :ip => "172.25.250.9" },
    { :name => "servera", :ip => "172.25.250.10" },
    { :name => "serverb", :ip => "172.25.250.11" },
  ]

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = "#{opts[:name]}.mydomain.com"
      config.vm.network :private_network, ip: opts[:ip]

      if opts[:name] == "serverb"
        config.vm.provision "ansible" do |ansible|
          ansible.playbook = "./playbooks/provision.yml"
          ansible.inventory_path = "./playbooks/inventory"
          ansible.limit = "all"
        end
      end
    end
  end

  VAGRANT_COMMAND = ARGV[0]
  if VAGRANT_COMMAND == "ssh"
    config.ssh.username = 'student'
  end

end
