FROM ubuntu:20.04 as base
ARG XTRABACKUP_PACKAGE_VERSION
ARG MYSQL_PACKAGE_VERSION

SHELL ["/bin/bash", "-c"]

# Pin the versions of mysql-server and percona-xtrabackup80 to the versions
# in /files (which must be updated)
COPY /files/mysql-server /etc/apt/preferences.d
COPY /files/percona-xtrabackup80 /etc/apt/preferences.d

RUN apt-get -qq update >/dev/null && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y -o Dpkg::Options::="--force-confold" curl libcurl4-openssl-dev lsb-release mysql-server wget >/dev/null

# If xtrabackup has been built into this repo, copy it in
# But that will be arm64, so we'll delete it if we're on amd64
COPY /files/install/lib* /usr/local
COPY /files/install/bin* /usr/local

SHELL ["/bin/bash", "-c"]

# xtrabackup-8.0 should always be installed, then ddev-dbserver won't have to install it.
# If on amd64 we'll get it from percona package
RUN if [ "$(arch)" = "x86_64" ]; then \
  rm -f /usr/local/bin/xb* /usr/local/bin/xtrabackup* /usr/local/lib/libmysqlservices.a ; \
  curl -o /tmp/xtrabackup.deb -sSL https://downloads.percona.com/downloads/Percona-XtraBackup-LATEST/Percona-XtraBackup-${XTRABACKUP_PACKAGE_VERSION%-*}/binary/debian/focal/x86_64/percona-xtrabackup-80_${XTRABACKUP_PACKAGE_VERSION}.focal_amd64.deb  && \
  dpkg -i /tmp/xtrabackup.deb >/dev/null && \
  rm /tmp/xtrabackup.deb ; \
  fi

# But if we still don't have it
RUN if ! command -v xtrabackup; then \
  wget -O /tmp/xtrabackup_arm64.tar.gz "https://github.com/drud/xtradb-arm64/releases/download/v0.0/xtrabackup8.0.26-ubuntu20.04-arm64.tar.gz"; \
  tar -C /usr/local -xzf /tmp/xtrabackup_arm64.tar.gz ; \
  rm -f /tmp/xtrabackup_arm64.tar.gz ; \
fi

RUN xtrabackup --version

FROM scratch as mysql
COPY --from=base / /
