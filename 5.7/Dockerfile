# Ubuntu 18.04 is used here because it has mysql-server-5.7
# and also has percona-xtrabackup
FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y -o Dpkg::Options::="--force-confold" -y mysql-server-5.7 percona-xtrabackup