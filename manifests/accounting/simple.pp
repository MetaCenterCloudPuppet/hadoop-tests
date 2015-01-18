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

node default {
  include stdlib

  include hadoop::namenode
  include hadoop::resourcemanager
  include hadoop::historyserver
  include hadoop::datanode
  include hadoop::nodemanager
  include hadoop::frontend
  class{'site_hadoop':
    mirror => 'scientific',
    stage  => 'setup',
  }
  include site_hadoop::devel::hadoop
  class{'site_hadoop::accounting':
    db_user          => 'accounting',
    db_password      => 'accpass',
    accounting_hdfs  => '* * * * *',
    accounting_quota => '* * * * *',
    accounting_jobs  => '10 0 * * *',
    principal        => '',
  }
  class{'mysql::server':
    root_password => 'strong_password',
  }
  mysql::db{'accounting':
    user => 'accounting',
    password => 'accpass',
    sql => '/usr/local/share/hadoop/accounting.sql',
  }

  Class['hadoop::namenode::service'] -> Class['site_hadoop::devel::hadoop']
  Class['site_hadoop::accounting'] -> Mysql::Db['accounting']
  Class['hadoop::namenode::install'] -> Class['site_hadoop::accounting']
}
