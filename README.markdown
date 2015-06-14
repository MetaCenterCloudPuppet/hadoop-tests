# Testing CESNET Hadoop modules with Vagrant

Available platforms:

 * Debian 7/wheezy
 * Fedora 21
 * (Ubuntu 14/trusty)
 * (RedHat 6)

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

    #cluster (high availability)
    make -j3 debs-ha
    #then on each machine:
    # puppet apply /vagrant/manifests/ha2.pp
    # puppet apply /vagrant/manifests/ha3.pp

## Hadoop Accounting
    # single node
    make deb-acc
    make fed-acc

    # cluster
    make -j3 debs-acc
    make -j3 feds-acc

## Hadoop Bookkeeping
    # single node
    make deb-book
    make fed-book

## HBase
    # single node
    make deb-hbase
    make fed-hbase

    # single node, with thrift and rest servers
    make deb-hbase-gates
    make fed-hbase-gates

## Hive
    #single node
    make deb-hive

    #cluster
    make -j3 debs-hive

    # mysql (single node)
    make hive-mysql

    # postgresql (single node)
    make hive-postgresql

    # server-less
    make hive-ultrasimple

## Oozie
    #single node
    make deb-oozie

    # mysql (single node)
    make oozie-mysql

    # postgresql (single node)
    make oozie-postgresql

## Pig
    #single node
    make deb-pig

    #cluster
    make -j3 debs-pig

## Zookeeper
    # simple
    make deb-zoo

    # cluster
    make -j3 debs-zoo

## Spark
    # simple (with Hadoop)
    make deb-spark

    # cluster (with Hadoop)
    make -j4 debs-spark
