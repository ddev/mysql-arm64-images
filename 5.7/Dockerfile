# Ubuntu 18.04 is used here because it has mysql-server-5.7
# and also has percona-xtrabackup
FROM ubuntu:18.04 as base
SHELL ["/bin/bash", "-c"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y -o Dpkg::Options::="--force-confold" -y mysql-server-5.7 percona-xtrabackup >/dev/null

RUN xtrabackup --version

FROM scratch as mysql
COPY --from=base / /
