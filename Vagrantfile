# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'socket'

hostname = Socket.gethostname
hostname.sub! /\.local$/, ''

pkg_base = "https://cloudflare.cdn.openbsd.org/pub/OpenBSD/6.2"
use_x11 = false # disable gui and xenodm, but still install X
openbsd_ver = pkg_base.match(/\d+\.\d/).to_s.sub '.','' # for x11 tarballs

Vagrant.configure("2") do |config|
  config.vm.box = "generic/openbsd6"
  config.vm.hostname = "#{hostname}-#{config.vm.box.match /[^\/]*$/}"

  config.vm.synced_folder "./data", "/vagrant_data", type: "rsync"
  config.vm.synced_folder "#{ENV['HOME']}/.skel", "/home/vagrant/.skel", type: "rsync",
    rsync__exclude: '.ssh/id_*'

  config.vm.provider "virtualbox" do |vb|
    vb.gui = use_x11
    vb.name = config.vm.hostname # doesnt work always
    vb.memory = 2048
    vb.linked_clone = true

    # Concurrent.physical_processor_count would be better, if it worked with vagrant Rubygems
    vb.cpus = 4
  end

  config.trigger.before :up do
    run "sh ./download-x11.sh #{pkg_base} '#{openbsd_ver}'"
  end

  config.ssh.username = ENV.fetch 'SSH_USER', "vagrant"
  config.ssh.forward_agent = config.ssh.username == 'vagrant'
  config.ssh.extra_args = %W(-o AddKeysToAgent=yes)

  config.vm.provision :shell, name: "hiddenfortress" do |s|
    s.path = "bootstrap.sh"
    s.env = {
      HOSTNAME: config.vm.hostname,
      CDN_BASE: pkg_base,
      X11: use_x11.to_s
    }
  end

  # these are specific to my configuration
  config.vm.provision :shell, name: "local" do |s|
    s.privileged = false
    s.inline = <<-SCRIPT
      ~/.skel/setup/openbsd.sh
      ~/.skel/bin/skeletor.sh
      exit 0
    SCRIPT
  end

  config.trigger.after :provision do
    confirm = nil
    until ["Y", "y", "N", "n"].include?(confirm) or not use_x11
      confirm = ask "Would you like to reboot to enact X11 changes now? (Y/N) "
    end
    run_remote "reboot" if use_x11 && confirm.upcase == "Y"
  end

end
