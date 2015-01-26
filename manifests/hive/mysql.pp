class{'hadoop':
  hdfs_hostname => $::fqdn,
  yarn_hostname => $::fqdn,
  slaves => [ $::fqdn ],
  frontends => [ $::fqdn ],
  realm => '',
  properties => {
    'dfs.replication' => 1,
  },
  features => {
    yellowmanager => true,
  },
}

class{"hive":
  metastore_hostname => $::fqdn,
  server2_hostname => $::fqdn,
  group => 'vagrant',
  realm => '',
  features => {
    manager => true,
  },
  db => 'mysql',
  db_password => 'hivepass',
}

node default {
  include stdlib

  include hadoop::namenode
  include hadoop::resourcemanager
  include hadoop::historyserver
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend
  include hive::hdfs
  include hive::metastore
  include hive::server2
  include hive::frontend
  include hive::hcatalog
  class{'site_hadoop':
    mirror => 'scientific',
    stage  => 'setup',
  }
  include site_hadoop::devel::hadoop

  class { 'mysql::server':
    root_password => 'strongpassword',
  }

  mysql::db { 'metastore':
    user     => 'hive',
    password => 'hivepass',
    host     => 'localhost',
    grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
    sql      => '/usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-0.13.0.mysql.sql',
  }

  class { 'mysql::bindings':
    java_enable => true,
  }

  Class['hadoop::namenode::service'] -> Class['site_hadoop::devel::hadoop']
  Class['hadoop::namenode::service'] -> Class['hive::metastore::service']
  Class['hadoop::namenode::service'] -> Class['hive::server2::service']
  Class['hive::metastore::install'] -> Mysql::Db['metastore']
  Mysql::Db['metastore'] -> Class['hive::metastore::service']
  Class['mysql::bindings'] -> Class['hive::metastore::config']
}
