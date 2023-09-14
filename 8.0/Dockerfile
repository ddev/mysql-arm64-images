FROM ubuntu:20.04 as base
ARG XTRABACKUP_PACKAGE_VERSION
ARG MYSQL_PACKAGE_VERSION
ARG TARGETPLATFORM
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# Pin the versions of mysql-server and percona-xtrabackup80 to the versions
# in /files (which must be updated)
COPY /files/mysql-server /etc/apt/preferences.d
COPY /files/percona-xtrabackup80 /etc/apt/preferences.d

RUN apt-get -qq update >/dev/null && apt-get -qq install -y -o Dpkg::Options::="--force-confold" curl libcurl4-openssl-dev libssl-dev zstd  >/dev/null

RUN apt install -y mysql-server >/dev/null || apt-get install -y mysql-server --fix-missing --fix-broken >/dev/null
ADD /mysql-8.0.33 /tmp
RUN ls -lR /tmp

RUN apt-get install -y --allow-downgrades -o Dpkg::Options::="--force-confnew" --no-install-recommends --no-install-suggests /tmp/archives-${TARGETPLATFORM#linux/}/*.deb >/dev/null

RUN apt-get -qq install -y -o Dpkg::Options::="--force-confold" libdbd-mysql-perl libev4 rsync wget  >/dev/null

RUN rm -rf /tmp/archives*

# If xtrabackup has been built into this repo, copy it in
# But that will be arm64, so we'll delete it if we're on amd64
COPY /files/install/lib* /usr/local
COPY /files/install/bin* /usr/local

# xtrabackup-8.0 should always be installed, then ddev-dbserver won't have to install it.
# If on amd64 we'll get it from percona package
# https://downloads.percona.com/downloads/Percona-XtraBackup-8.0/Percona-XtraBackup-8.0.31-24/binary/debian/buster/x86_64/percona-xtrabackup-80_8.0.31-24-1.buster_amd64.deb
RUN if [ "$(arch)" = "x86_64" ]; then \
  set -eu -o pipefail; \
  rm -f /usr/local/bin/xb* /usr/local/bin/xtrabackup* /usr/local/lib/libmysqlservices.a ; \
  set -x && curl -s -L --fail -o /tmp/xtrabackup.deb https://downloads.percona.com/downloads/Percona-XtraBackup-8.0/Percona-XtraBackup-${XTRABACKUP_PACKAGE_VERSION%-*}/binary/debian/focal/x86_64/percona-xtrabackup-80_${XTRABACKUP_PACKAGE_VERSION}.focal_amd64.deb  && \
  dpkg -i /tmp/xtrabackup.deb >/dev/null && \
  rm /tmp/xtrabackup.deb ; \
  fi

# But if we still don't have it (arm64)
RUN if ! command -v xtrabackup; then \
  URL="https://github.com/ddev/xtrabackup-build/releases/download/${XTRABACKUP_PACKAGE_VERSION%-*}/xtrabackup-${XTRABACKUP_PACKAGE_VERSION%-*}-arm64.tar.gz" && \
  cd /tmp && \
  wget ${URL} && \
  wget ${URL}.sha256.txt && \
  shasum -a 256 xtrabackup-*.sha256.txt && \
  tar -C /usr/local -xzf xtrabackup-*-arm64.tar.gz && \
  rm -f xtrabackup-* ; \
fi

RUN xtrabackup --version

FROM scratch as mysql
COPY --from=base / /
