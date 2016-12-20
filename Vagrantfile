Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.1"

  config.ssh.password = 'vagrant'

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.synced_folder ".", "/home/vagrant/flashcards", create: true

  config.vm.provision "shell", path: "ror_setup.sh"
end
