class{'hadoop':
  hdfs_hostname => $::fqdn,
  yarn_hostname => $::fqdn,
  slaves => [ $::fqdn ],
  frontends => [ $::fqdn ],
  realm => '',
  properties => {
    'dfs.replication' => 1,
    'hadoop.proxyuser.oozie.groups' => '*',
    'hadoop.proxyuser.oozie.hosts'  => '*',
  },
  features => {
    yellowmanager => true,
  },
}

class{'oozie':
  hdfs_hostname => $::fqdn,
  realm => '',
  db => 'postgresql',
  db_password => 'oopass',
}

node default {
  include stdlib

  include hadoop::namenode
  include hadoop::resourcemanager
  include hadoop::historyserver
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend
  include oozie::hdfs
  include oozie::server
  include oozie::client
  class{'site_hadoop':
    mirror => 'scientific',
    stage  => 'setup',
  }
  include site_hadoop::devel::hadoop

  class { 'postgresql::server':
    listen_addresses => 'localhost',
  }

  include postgresql::lib::java

  postgresql::server::db { 'oozie':
    user     => 'oozie',
    password => postgresql_password('oozie', 'oopass'),
  }

  Class['hadoop::namenode::service'] -> Class['site_hadoop::devel::hadoop']
  Class['hadoop::datanode::service'] -> Class['oozie::server::config']
  Class['oozie::hdfs'] -> Class['oozie::server::config']
  Class['postgresql::lib::java'] -> Class['oozie::server::config']
  Postgresql::Server::Db['oozie'] -> Class['oozie::server::service']
}
