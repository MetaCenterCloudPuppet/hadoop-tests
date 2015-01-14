debs=deb-hdfs deb-yarn deb-node
feds=fed-hdfs fed-yarn fed-node
#feds_hive=fed-hive-hdfs fed-hive-yarn fed-hive-node
debs_hive=deb-hive-hdfs deb-hive-yarn deb-hive-node

all: deb

fed fed-plain $(feds) fed-hive fed-hbase $(feds_hive) deb deb-plain $(debs) deb-hive deb-hbase $(debs_hive) hive-mysql hive-postgresql:
	vagrant up $@

feds: $(feds)

debs: $(debs)

#feds-hive: $(feds_hive)

debs-hive: $(debs_hive)
