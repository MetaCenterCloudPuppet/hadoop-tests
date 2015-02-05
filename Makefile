debs=deb-hdfs deb-yarn deb-node
feds=fed-hdfs fed-yarn fed-node
#feds_hive=fed-hive-hdfs fed-hive-yarn fed-hive-node
debs_hive=deb-hive-hdfs deb-hive-yarn deb-hive-node
feds_acc=fed-acc-hdfs fed-acc-yarn fed-acc-node
debs_acc=deb-acc-hdfs deb-acc-yarn deb-acc-node
debs_pig=deb-pig-hdfs deb-pig-yarn deb-pig-node

all: deb

fed fed-plain $(feds) fed-hive fed-hbase $(feds_hive) fed-acc $(feds_acc) deb deb-plain $(debs) deb-hive deb-hbase $(debs_hive) hive-mysql hive-postgresql deb-acc $(debs_acc) deb-oozie oozie-mysql oozie-postgresql deb-pig $(debs_pig):
	vagrant up $@

feds: $(feds)

debs: $(debs)

#feds-hive: $(feds_hive)

debs-hive: $(debs_hive)

feds-acc: $(feds_acc)

debs-acc: $(debs_acc)

debs-pig: $(debs_pig)
