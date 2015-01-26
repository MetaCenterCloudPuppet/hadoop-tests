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
  db => 'mysql',
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

  class { 'mysql::server':
    root_password => 'strongpassword',
  }

  class { 'mysql::bindings':
    java_enable => true,
  }

  mysql::db { 'oozie':
    user     => 'oozie',
    password => 'oopass',
    host     => 'localhost',
    grant    => ['CREATE', 'INDEX', 'SELECT', 'INSERT', 'UPDATE', 'DELETE'],
  }

  Class['hadoop::namenode::service'] -> Class['site_hadoop::devel::hadoop']
  Class['hadoop::datanode::service'] -> Class['oozie::server::config']
  Class['oozie::hdfs'] -> Class['oozie::server::config']
  Class['mysql::bindings'] -> Class['oozie::server::config']
  Mysql::Db['oozie'] -> Class['oozie::server::service']
}
