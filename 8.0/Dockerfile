FROM ubuntu:20.04 as base

RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y -o Dpkg::Options::="--force-confold" curl mysql-server-8.0 wget >/dev/null

# If xtrabackup has been built into this repo, copy it in
# But that will be arm64, so we'll delete it if we're on amd64
COPY /files/install/lib* /usr/local
COPY /files/install/bin* /usr/local

SHELL ["/bin/bash", "-c"]

# xtrabackup-8.0 should always be installed, then ddev-dbserver won't have to install it.
# If on amd64 we'll get it from percona package
RUN if [ "$(arch)" = "amd64" ]; then \
  rm -f /usr/local/bin/xb* /usr/local/bin/xtrabackup* /usr/local/lib/libmysqlservices.a ; \
  curl -sSL https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb -o percona-release_latest.$(lsb_release -sc)_all.deb && \
  dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb >/dev/null && \
  rm percona-release*.deb && \
  apt-get -qq update && apt-get -qq install -y percona-xtrabackup-8.0 >/dev/null; \
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
