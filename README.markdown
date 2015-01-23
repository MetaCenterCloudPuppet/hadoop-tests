# Testing CESNET Hadoop modules with Vagrant

Available platforms:

 * Debian 7
 * Fedora 21

Machines can be launch with <tt>vagrant up MACHINE</tt>, or there is convenient Makefile for parallel launch.

# Initial Setup

    mkdir ./modules
    vagrant up deb-plain
    vagrant ssh deb-plain
      sudo su
      for m in cesnet-hadoop cesnet-hbase cesnet-hive cesnet-sit_hadoop cesnet-zookeeper puppetlabs-mysql puppetlabs-postgresql; do puppet module install ${m}; done

# Tests

## Plain Machine (no tests)
    make deb-plain
    make fed-plain

## Hadoop
    #single node
    make deb
    make fed

    #cluster
    make -j3 debs
    make -j3 feds

## Hadoop Accounting
    # single node
    make deb-acc
    make fed-acc

    # cluster
    make -j3 debs-acc
    make -j3 feds-acc

## HBase
    # single node
    make deb-hbase
    make fed-hbase

## Hive
    #single node
    make deb-hive

    #cluster
    make -j3 debs-hive

    # mysql (single node)
    make hive-mysql

    # postgresql (single node)
    make hive-postgresql

## Oozie
    #single node
    make deb-oozie
