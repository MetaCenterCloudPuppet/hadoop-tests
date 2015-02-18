# -*- mode: ruby -*-
# vi: set ft=ruby :

NAME=["fed-plain", "fed", "fed-hdfs", "fed-yarn", "fed-node",
      "fed-hive", "fed-hbase", "fed-acc", "fed-acc-hdfs", "fed-acc-yarn",
      "fed-acc-node", "deb-plain", "deb", "deb-hdfs", "deb-yarn",
      "deb-node", "deb-hive", "deb-hbase", "deb-hive-hdfs", "deb-hive-yarn",
      "deb-hive-node", "hive-mysql", "hive-postgresql", "deb-acc", "deb-acc-hdfs",
      "deb-acc-yarn", "deb-acc-node", "deb-oozie", "oozie-mysql", "oozie-postgresql",
      "deb-pig", "deb-pig-hdfs", "deb-pig-yarn", "deb-pig-node", "hive-ultrasimple"]
DOMAIN="vagrant"
NETWORK="192.168.42"
INITIAL_IP=101
# offsets in the IP/NAME arrays
FED=0
DEB=11

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # problems with the interface names
  #config.vm.box = "box-cutter/fedora21"

  # disabled SELinux
  # enabled firewalld
  # (used here)
  #config.vm.box = "hansode/fedora-21-server-x86_64"

  f21_image="hansode/fedora-21-server-x86_64"
  deb7_image="cargomedia/debian-7-amd64-plain"
  #deb7_image="ubuntu/trusty64"
  # not supported: ubuntu/precise, ubuntu/lucid, puppetlabs/centos-6.5-64-puppet

  # single-node cluster
  big_memory="4096"
  # nodes
  small_memory="2048"

  $script = <<SCRIPT
domain="${1}"
network="${2}"
ip="${3}"
shift
shift
shift
cat > /etc/hosts <<EOF
127.0.0.1	localhost localhost.localdomain localhost4 localhost4.localdomain4
::1	localhost localhost.localdomain localhost6 localhost6.localdomain6
EOF
while test -n "$1"; do
  echo "${network}.${ip}	${1}.${domain} ${1}" >> /etc/hosts
  shift
  let ip=ip+1
done

hostname > /etc/hostname
SCRIPT
  config.vm.provision "shell", run: "always" do |s|
    s.inline = $script
    s.args   = [DOMAIN, NETWORK, INITIAL_IP, NAME[0], NAME[1], NAME[2], NAME[3], NAME[4], NAME[5], NAME[6], NAME[7], NAME[8], NAME[9], NAME[10], NAME[11], NAME[12], NAME[13], NAME[14], NAME[15], NAME[16], NAME[17], NAME[18], NAME[19], NAME[20], NAME[21], NAME[22], NAME[23], NAME[24], NAME[25], NAME[26], NAME[27], NAME[28], NAME[29], NAME[30], NAME[31], NAME[32], NAME[33], NAME[34]]
  end
  config.vm.provision "shell", inline: "/vagrant/scripts/bootstrap.sh"

  config.vm.synced_folder "modules/", "/etc/puppet/modules"
  config.vm.synced_folder "manifests/", "/etc/puppet/manifests"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", big_memory]
  end

  IP=INITIAL_IP

  config.vm.define NAME[FED+0] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+0).to_s
    fed.vm.hostname=NAME[FED+0]
  end

  config.vm.define NAME[FED+1] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+1).to_s
    fed.vm.hostname=NAME[FED+1]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "simple.pp"
    end
  end

  config.vm.define NAME[FED+2] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+2).to_s
    fed.vm.hostname=NAME[FED+2]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    fed.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[FED+3] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+3).to_s
    fed.vm.hostname=NAME[FED+3]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    fed.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[FED+4] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+4).to_s
    fed.vm.hostname=NAME[FED+4]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    fed.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[FED+5] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+5).to_s
    fed.vm.hostname=NAME[FED+5]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/simple.pp"
    end
  end

  config.vm.define NAME[FED+6] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+6).to_s
    fed.vm.hostname=NAME[FED+6]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hbase/simple-zoo.pp"
    end
  end

  config.vm.define NAME[FED+7] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+7).to_s
    fed.vm.hostname=NAME[FED+7]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "accounting/simple.pp"
    end
  end

  config.vm.define NAME[FED+8] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+8).to_s
    fed.vm.hostname=NAME[FED+8]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "accounting/cluster.pp"
    end
    fed.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[FED+9] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+9).to_s
    fed.vm.hostname=NAME[FED+9]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "accounting/cluster.pp"
    end
    fed.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[FED+10] do |fed|
    fed.vm.box = f21_image
    fed.vm.network "private_network", ip: NETWORK + '.' + (IP+FED+10).to_s
    fed.vm.hostname=NAME[FED+10]
    fed.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "accounting/cluster.pp"
    end
    fed.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+0] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+0).to_s
    deb.vm.hostname=NAME[DEB+0]
  end

  config.vm.define NAME[DEB+1] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+1).to_s
    deb.vm.hostname=NAME[DEB+1]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "simple.pp"
    end
  end

  config.vm.define NAME[DEB+2] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+2).to_s
    deb.vm.hostname=NAME[DEB+2]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+3] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+3).to_s
    deb.vm.hostname=NAME[DEB+3]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+4] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+4).to_s
    deb.vm.hostname=NAME[DEB+4]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+5] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+5).to_s
    deb.vm.hostname=NAME[DEB+5]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/simple.pp"
    end
  end

  config.vm.define NAME[DEB+6] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+6).to_s
    deb.vm.hostname=NAME[DEB+6]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hbase/simple.pp"
    end
  end

  config.vm.define NAME[DEB+7] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+7).to_s
    deb.vm.hostname=NAME[DEB+7]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+8] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+8).to_s
    deb.vm.hostname=NAME[DEB+8]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+9] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+9).to_s
    deb.vm.hostname=NAME[DEB+9]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+10] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+10).to_s
    deb.vm.hostname=NAME[DEB+10]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/mysql.pp"
    end
  end

  config.vm.define NAME[DEB+11] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+11).to_s
    deb.vm.hostname=NAME[DEB+11]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/postgresql.pp"
    end
  end

  config.vm.define NAME[DEB+12] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+12).to_s
    deb.vm.hostname=NAME[DEB+12]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "accounting/simple.pp"
    end
  end

  config.vm.define NAME[DEB+13] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+13).to_s
    deb.vm.hostname=NAME[DEB+13]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "accounting/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+14] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+14).to_s
    deb.vm.hostname=NAME[DEB+14]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "accounting/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+15] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+15).to_s
    deb.vm.hostname=NAME[DEB+15]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "accounting/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+16] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+16).to_s
    deb.vm.hostname=NAME[DEB+16]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "oozie/simple.pp"
    end
  end

  config.vm.define NAME[DEB+17] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+17).to_s
    deb.vm.hostname=NAME[DEB+17]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "oozie/mysql.pp"
    end
  end

  config.vm.define NAME[DEB+18] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+18).to_s
    deb.vm.hostname=NAME[DEB+18]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "oozie/postgresql.pp"
    end
  end

  config.vm.define NAME[DEB+19] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+19).to_s
    deb.vm.hostname=NAME[DEB+19]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "pig/simple.pp"
    end
  end

  config.vm.define NAME[DEB+20] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+20).to_s
    deb.vm.hostname=NAME[DEB+20]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "pig/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+21] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+21).to_s
    deb.vm.hostname=NAME[DEB+21]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "pig/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+22] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+22).to_s
    deb.vm.hostname=NAME[DEB+22]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "pig/cluster.pp"
    end
    deb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", small_memory]
    end
  end

  config.vm.define NAME[DEB+23] do |deb|
    deb.vm.box = deb7_image
    deb.vm.network "private_network", ip: NETWORK + '.' + (IP+DEB+23).to_s
    deb.vm.hostname=NAME[DEB+23]
    deb.vm.provision :puppet do |puppet|
      puppet.manifests_path = "manifests"
      puppet.module_path    = "modules"
      puppet.manifest_file  = "hive/ultrasimple.pp"
    end
  end

end
