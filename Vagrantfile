# -*- mode: ruby -*-
# vi: set ft=ruby :

# single-node cluster
big_memory='4096'
# nodes
node_memory='2048'
# masters
daemon_memory='1024'

# problems with the interface names
#config.vm.box = 'box-cutter/fedora21'

# disabled SELinux
# enabled firewalld
# (used here)
#config.vm.box = 'hansode/fedora-21-server-x86_64'

f21_image='hansode/fedora-21-server-x86_64'
deb7_image='cargomedia/debian-7-amd64-plain'
#deb7_image='ubuntu/trusty64'
# requires special puppet+ruby: ubuntu/precise, ubuntu/lucid, puppetlabs/centos-6.5-64-puppet
el6_image='puppetlabs/centos-6.5-64-nocm'

BOX=[
	{ :name => 'fed-plain',        :image => f21_image,  :memory => daemon_memory },
	{ :name => 'fed',              :image => f21_image,  :manifest => 'simple.pp', :memory => big_memory },
	{ :name => 'fed-hdfs',         :image => f21_image,  :manifest => 'cluster.pp', :memory => daemon_memory },
	{ :name => 'fed-yarn',         :image => f21_image,  :manifest => 'cluster.pp', :memory => daemon_memory },
	{ :name => 'fed-node',         :image => f21_image,  :manifest => 'cluster.pp', :memory => node_memory },
	{ :name => 'fed-hive',         :image => f21_image,  :manifest => 'hive/simple.pp', :memory => big_memory },
	{ :name => 'fed-hbase',        :image => f21_image,  :manifest => 'hbase/simple.pp', :memory => big_memory },
	{ :name => 'fed-hbase-gates',  :image => f21_image,  :manifest => 'hbase/gateways.pp', :memory => big_memory },
	{ :name => 'fed-acc',          :image => f21_image,  :manifest => 'accounting/simple.pp', :memory => big_memory },
	{ :name => 'fed-acc-hdfs',     :image => f21_image,  :manifest => 'accounting/cluster.pp', :memory => daemon_memory },
	{ :name => 'fed-acc-yarn',     :image => f21_image,  :manifest => 'accounting/cluster.pp', :memory => daemon_memory },
	{ :name => 'fed-acc-node',     :image => f21_image,  :manifest => 'accounting/cluster.pp', :memory => node_memory },
	{ :name => 'deb-plain',        :image => deb7_image, :memory => daemon_memory },
	{ :name => 'deb',              :image => deb7_image, :manifest => 'simple.pp', :memory => big_memory },
	{ :name => 'deb-hdfs',         :image => deb7_image, :manifest => 'cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-yarn',         :image => deb7_image, :manifest => 'cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-node',         :image => deb7_image, :manifest => 'cluster.pp', :memory => node_memory },
	{ :name => 'deb-hive',         :image => deb7_image, :manifest => 'hive/simple.pp', :memory => big_memory },
	{ :name => 'deb-hbase',        :image => deb7_image, :manifest => 'hbase/simple.pp', :memory => big_memory },
	{ :name => 'deb-hbase-gates',  :image => deb7_image, :manifest => 'hbase/gateways.pp', :memory => big_memory },
	{ :name => 'deb-hive-hdfs',    :image => deb7_image, :manifest => 'hive/cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-hive-yarn',    :image => deb7_image, :manifest => 'hive/cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-hive-node',    :image => deb7_image, :manifest => 'hive/cluster.pp', :memory => node_memory },
	{ :name => 'hive-mysql',       :image => deb7_image, :manifest => 'hive/mysql.pp', :memory => big_memory },
	{ :name => 'hive-postgresql',  :image => deb7_image, :manifest => 'hive/postgresql.pp', :memory => big_memory },
	{ :name => 'deb-acc',          :image => deb7_image, :manifest => 'accounting/simple.pp', :memory => big_memory },
	{ :name => 'deb-acc-hdfs',     :image => deb7_image, :manifest => 'accounting/cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-acc-yarn',     :image => deb7_image, :manifest => 'accounting/cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-acc-node',     :image => deb7_image, :manifest => 'accounting/cluster.pp', :memory => node_memory },
	{ :name => 'deb-oozie',        :image => deb7_image, :manifest => 'oozie/simple.pp', :memory => big_memory },
	{ :name => 'oozie-mysql',      :image => deb7_image, :manifest => 'oozie/mysql.pp', :memory => big_memory },
	{ :name => 'oozie-postgresql', :image => deb7_image, :manifest => 'oozie/postgress.pp', :memory => big_memory },
	{ :name => 'deb-pig',          :image => deb7_image, :manifest => 'pig/simple.pp', :memory => big_memory },
	{ :name => 'deb-pig-hdfs',     :image => deb7_image, :manifest => 'pig/cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-pig-yarn',     :image => deb7_image, :manifest => 'pig/cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-pig-node',     :image => deb7_image, :manifest => 'pig/cluster.pp', :memory => node_memory },
	{ :name => 'hive-ultrasimple', :image => deb7_image, :manifest => 'hive/ultrasimple.pp', :memory => big_memory },
	{ :name => 'deb-zoo',          :image => deb7_image, :manifest => 'zookeeper/simple.pp', :memory => daemon_memory },
	{ :name => 'deb-zoo1',         :image => deb7_image, :manifest => 'zookeeper/cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-zoo2',         :image => deb7_image, :manifest => 'zookeeper/cluster.pp', :memory => daemon_memory },
	{ :name => 'deb-zoo3',         :image => deb7_image, :manifest => 'zookeeper/cluster.pp', :memory => daemon_memory },
]
DOMAIN='vagrant'
NETWORK='192.168.42'
INITIAL_IP=101

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
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
  config.vm.provision 'shell', run: 'always' do |s|
    s.inline = $script
    s.args   = [DOMAIN, NETWORK, INITIAL_IP, BOX[0][:name], BOX[1][:name], BOX[2][:name], BOX[3][:name], BOX[4][:name], BOX[5][:name], BOX[6][:name], BOX[7][:name], BOX[8][:name], BOX[9][:name], BOX[10][:name], BOX[11][:name], BOX[12][:name], BOX[13][:name], BOX[14][:name], BOX[15][:name], BOX[16][:name], BOX[17][:name], BOX[18][:name], BOX[19][:name], BOX[20][:name], BOX[21][:name], BOX[22][:name], BOX[23][:name], BOX[24][:name], BOX[25][:name], BOX[26][:name], BOX[27][:name], BOX[28][:name], BOX[29][:name], BOX[30][:name], BOX[31][:name], BOX[32][:name], BOX[33][:name], BOX[34][:name], BOX[35][:name], BOX[36][:name], BOX[37][:name], BOX[38][:name], BOX[39][:name]]
  end
  config.vm.provision 'shell', inline: '/vagrant/scripts/bootstrap.sh'

  config.vm.synced_folder 'modules/', '/etc/puppet/modules'
  config.vm.synced_folder 'manifests/', '/etc/puppet/manifests'

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--memory', big_memory]
  end

  BOX.each_with_index do |box,i|
    config.vm.define box[:name] do |mach|
      mach.vm.box = box[:image]
      mach.vm.network 'private_network', ip: NETWORK + '.' + (INITIAL_IP + i).to_s
      mach.vm.hostname=box[:name]
      if box[:manifest]
        mach.vm.provision :puppet do |puppet|
          puppet.manifests_path = 'manifests'
          puppet.module_path    = 'modules'
          puppet.manifest_file  = box[:manifest]
        end
      end
      if box[:memory]
        mach.vm.provider 'virtualbox' do |vb|
          vb.customize ['modifyvm', :id, '--memory', box[:memory]]
        end
      end
    end
  end

end
