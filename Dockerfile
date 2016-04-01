FROM nimmis/java-centos:openjdk-8-jre-headless
MAINTAINER jenskat

USER root

ADD datastax.repo /etc/yum.repos.d/datastax.repo
RUN yum install -y dse-full && \
	yum clean all

VOLUME ["/data"]

# Expose ports
EXPOSE 7199 7000 7001 9160 9042

# We use the "sh -c" to turn around https://github.com/docker/docker/issues/5509 - variable not expanded
ENTRYPOINT ["sh", "-c"]

CMD [""]
