debs=deb-hdfs deb-yarn deb-node
feds=fed-hdfs fed-yarn fed-node

all: deb

fed fed-plain $(feds) fed-hive fed-hbase deb deb-plain $(debs) deb-hive deb-hbase:
	vagrant up $@

feds: $(feds)

debs: $(debs)
