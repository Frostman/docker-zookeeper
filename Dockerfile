FROM ubuntu:14.04

ENV zookeeper_version ${zookeeper_version:-"3.4.6"}

# install Java
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y default-jre

# install zookeeper

ADD http://www.us.apache.org/dist/zookeeper/zookeeper-${zookeeper_version}/zookeeper-${zookeeper_version}.tar.gz /opt/zookeeper.tar.gz

WORKDIR /opt

RUN tar xzf zookeeper.tar.gz && \
    ln -s zookeeper-${zookeeper_version} zookeeper && \
    rm zookeeper.tar.gz

# configure zookeeper

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

ADD run_zk.sh /opt/zookeeper/

#CMD ipaddr=$(ip -4 addr show scope global dev eth0 | grep inet | awk '{print $2}' | cut -d / -f 1) && \
#    echo "server.${zoo_id}=$ipaddr:2888:3888" >> conf/zoo.cfg && \
#    data_dir="/var/lib/zookeeper" && \
#    mkdir -p /var/lib/zookeeper && \
#    echo ${zoo_id} > ${data_dir}/myid && \
#    ./bin/zkServer.sh start-foreground
CMD ./run_zk.sh
