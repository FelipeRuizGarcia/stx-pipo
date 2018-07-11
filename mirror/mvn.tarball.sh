#!/bin/bash

mvn="mvn"
for artf in $(cat mvn-artifacts.lst);do
	current=./$mvn/$artf
	mkdir -p $(dirname $current)
	wget https://repo.maven.apache.org/maven2/$artf -O $current
done;

tar -zcvf mvn.repo.tgz  -C mvn/ .
