FROM java:openjdk-8u72-jdk
MAINTAINER jenskat

RUN apt-get update && apt-get -y install curl apt-transport-https sudo
ADD datastax.sources.list /etc/apt/sources.list.d/datastax.sources.list
RUN curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -

RUN apt-get update && apt-get -y install supervisor dse-full

VOLUME ["/var/lib/cassandra/data"]

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY dse /etc/default/dse
COPY cassandra.yaml /etc/dse/cassandra/cassandra.yaml

# http://docs.datastax.com/en/datastax_enterprise/4.8/datastax_enterprise/sec/secConfFirePort.html
EXPOSE 4040 7080 7081 8888 9160

#Solr port, inter-node
EXPOSE 8983 8984

#Cassandra inter-node,ssl, jmx
EXPOSE 7000 7001 7199

#Spark Master
EXPOSE 8984

#CQL
EXPOSE 9042

#HIVE
EXPOSE 10000

#OpsCenter
EXPOSE 50031 61620 61621

ENV CASSANDRA_CONFIG /etc/dse/cassandra

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
