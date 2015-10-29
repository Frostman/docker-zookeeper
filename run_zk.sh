#!/bin/bash

set -eux

ipaddr=$(ip -4 addr show scope global dev eth0 | grep inet | awk '{print $2}' | cut -d / -f 1)
echo "server.${zoo_id}=$ipaddr:2888:3888" >> conf/zoo.cfg

mkdir -p ${data_dir}
echo ${zoo_id} > ${data_dir}/myid
./bin/zkServer.sh start-foreground
