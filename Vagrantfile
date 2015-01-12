# -*- mode: ruby -*-
# vi: set ft=ruby :

IP=["192.168.42.101", "192.168.42.102", "192.168.42.103", "192.168.42.104", "192.168.42.105", "192.168.42.106", "192.168.42.107", "192.168.42.108", "192.168.42.109", "192.168.42.110", "192.168.42.111", "192.168.42.112", "192.168.42.113", "192.168.42.114", "192.168.42.115", "192.168.42.116", "192.168.42.117"]
NAME=["fed-plain", "fed", "fed-hdfs", "fed-yarn", "fed-node", "fed-hive", "fed-hbase", "deb-plain", "deb", "deb-hdfs", "deb-yarn", "deb-node", "deb-hive", "deb-hbase", "deb-hive-hdfs","deb-hive-yarn", "deb-hive-node"]
DOMAIN="vagrant"
# offsets in the IP/NAME arrays
FED=0
DEB=7

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # problems with the interface names
  #config.vm.box = "box-cutter/fedora21"

  # disabled SELinux
  # enabled firewalld
  # (used here)
  #config.vm.box = "hansode/fedora-21-server-x86_64"

  $script = <<SCRIPT
domain=$1
shift
cat > /etc/hosts <<EOF
127.0.0.1	localhost localhost.localdomain localhost4 localhost4.localdomain4
::1	localhost localhost.localdomain localhost6 localhost6.localdomain6
EOF
while test -n "$1"; do
  echo "${1}	${2}.${domain} ${2}" >> /etc/hosts
  shift
  shift
done

hostname > /etc/hostname
SCRIPT
  config.vm.provision "shell", run: "always" do |s|
    s.inline = $script
    s.args   = [DOMAIN, IP[0], NAME[0], IP[1], NAME[1], IP[2], NAME[2], IP[3], NAME[3], IP[4], NAME[4], IP[5], NAME[5], IP[6], NAME[6], IP[7], NAME[7], IP[8], NAME[8], IP[9], NAME[9], IP[10], NAME[10], IP[11], NAME[11], IP[12], NAME[12], IP[13], NAME[13], IP[14], NAME[14], IP[15], NAME[15], IP[16], NAME[16], IP[17], NAME[17], IP[18], NAME[18], IP[19], NAME[19]]
  end
  config.vm.provision "shell", inline: "/vagrant/scripts/bootstrap.sh"

  config.vm.synced_folder "modules/", "/etc/puppet/modules"
  config.vm.synced_folder "manifests/", "/etc/puppet/manifests"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  end

  config.vm.define NAME[FED+0] do |fed|
    fed.vm.box = "hansode/fedora-21-server-x86_64"
    fed.vm.network "private_network", ip: IP[FED+0]
    fed.vm.hostname=NAME[FED+0]
  end

  config.vm.define NAME[FED+1] do |fed|
    fed.vm.box = "hansode/fedora-21-server-x86_64"
    fed.vm.network "private_network", ip: IP[FED+1]
    fed.vm.hostname=NAME[FED+1]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "simple.pp"
    end
  end

  config.vm.define NAME[FED+2] do |fed|
    fed.vm.box = "hansode/fedora-21-server-x86_64"
    fed.vm.network "private_network", ip: IP[FED+2]
    fed.vm.hostname=NAME[FED+2]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    fed.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  config.vm.define NAME[FED+3] do |fed|
    fed.vm.box = "hansode/fedora-21-server-x86_64"
    fed.vm.network "private_network", ip: IP[FED+3]
    fed.vm.hostname=NAME[FED+3]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    fed.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  config.vm.define NAME[FED+4] do |fed|
    fed.vm.box = "hansode/fedora-21-server-x86_64"
    fed.vm.network "private_network", ip: IP[FED+4]
    fed.vm.hostname=NAME[FED+4]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
  end

  config.vm.define NAME[FED+5] do |fed|
    fed.vm.box = "hansode/fedora-21-server-x86_64"
    fed.vm.network "private_network", ip: IP[FED+5]
    fed.vm.hostname=NAME[FED+5]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/simple.pp"
    end
  end

  config.vm.define NAME[FED+6] do |fed|
    fed.vm.box = "hansode/fedora-21-server-x86_64"
    fed.vm.network "private_network", ip: IP[FED+6]
    fed.vm.hostname=NAME[FED+6]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hbase/simple-zoo.pp"
    end
  end

  config.vm.define NAME[DEB+0] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+0]
    deb.vm.hostname=NAME[DEB+0]
  end

  config.vm.define NAME[DEB+1] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+1]
    deb.vm.hostname=NAME[DEB+1]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "simple.pp"
    end
  end

  config.vm.define NAME[DEB+2] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+2]
    deb.vm.hostname=NAME[DEB+2]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  config.vm.define NAME[DEB+3] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+3]
    deb.vm.hostname=NAME[DEB+3]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  config.vm.define NAME[DEB+4] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+4]
    deb.vm.hostname=NAME[DEB+4]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
  end

  config.vm.define NAME[DEB+5] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+5]
    deb.vm.hostname=NAME[DEB+5]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/simple.pp"
    end
  end

  config.vm.define NAME[DEB+6] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+6]
    deb.vm.hostname=NAME[DEB+6]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hbase/simple.pp"
    end
  end

  config.vm.define NAME[DEB+7] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+7]
    deb.vm.hostname=NAME[DEB+7]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  config.vm.define NAME[DEB+8] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+8]
    deb.vm.hostname=NAME[DEB+8]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

  config.vm.define NAME[DEB+9] do |deb|
    deb.vm.box = "cargomedia/debian-7-amd64-plain"
    deb.vm.network "private_network", ip: IP[DEB+9]
    deb.vm.hostname=NAME[DEB+9]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "2048"]
    end
  end

end
