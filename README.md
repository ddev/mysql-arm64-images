# ddev/mysql-arm64-images docker images (ddev/ddev-mysql)

## Overview

Build tools for mysql arm64 images

Oracle does not publish any arm64 images for mysql, but people on Apple Silicon (DDEV) certainly need native images.

This repo is used for publishing those images, and is used to build `ddev/ddev-dbserver-mysql-8.0` and `ddev/ddev-dbserver-mysql-5.7`

### Features

These images are built on upstream Ubuntu.

## Preparation

Because mysql-server-8.0 is usually ahead of the released xtrabackup version, it's important to capture the mysql-server and mysql-client deb files ahead of time, when we're expecting a new xtrabackup version.

The script `8.0/capture-mysql8-debs.sh` will download the named version's Debian packages. `cd 8.0 && ./capture-mysql8-debs.sh` and then update the Dockerfile to use the new packages. This only works on systems like Apple Silicon that can run both linux/amd64 and linux/arm64 containers.

This does the things below.

> To do this, for both PLATFORM=linux/amd64 and PLATFORM=linux/arm64, `docker run -it --platform=$PLATFORM --rm ubuntu:20.04 bash` and `apt update && apt upgrade -y && apt install -y mysql-server` and then remove all that with `apt remove mysql-server mysql-client && apt autoremove`. This should put the system in position where the exact needed items will be downloaded with `apt install -y --download-only mysql-server-8.0`, after which all the need .deb files will be in /var/cache/apt/archives and they can be updated into the replacement of mysql-8.0.33.

## Building and pushing

* Push both with ./push.sh in the top-level directory or
* In the proper directory, use `push.sh` to push or `build.sh` to test a build.
* When a new minor version of mysql is released, update the proper base_version.txt
* Note that mysql 8.0 should only be updated to a new minor version *after* the xtrabackup-8.0 version that supports it (that has the same or higher major version)
* xtrabackup-8.0 is built for arm64 in [xtrabackup-build](https://github.com/ddev/xtrabackup-build), so you'll need a new release there if a new release for mysql 8.0 comes out, because xtrabackup-8.0 always has to be at least the version of mysql 8.0
* So before updating mysql 8.0, change `files/install/mysql-server`, `files/install/percona-xtrabackup80`, `mysql_version.txt`, and `xtrabackup_version.txt` to the correct versions.
* Then create a new release. The proper tags will be pushed for ddev/mysql:5.7 and ddev/mysql:8.0


### Running
To run the container by itself:

```bash
docker run -it --rm --entrypoint=bash ddev/ddev-mysql:<tag> bash
```

## Source:

[https://github.com/ddev/mysql-arm64-images](https://github.com/ddev/mysql-arm64-images)

## Maintained by:

The [DDEV Docker Maintainers](https://github.com/ddev)

## Where to get help:

* [DDEV Community Discord](https://discord.gg/5wjP76mBJD)
* [Stack Overflow](https://stackoverflow.com/questions/tagged/ddev)

## Where to file issues:

https://github.com/ddev/ddev/issues

## Documentation:

* https://ddev.readthedocs.io/
* https://ddev.com/

## What is DDEV?

[DDEV](https://github.com/ddev/ddev) is an open source tool for launching local web development environments in minutes. It supports PHP, Node.js, and Python (experimental).

These environments can be extended, version controlled, and shared, so you can take advantage of a Docker workflow without Docker experience or bespoke configuration. Projects can be changed, powered down, or removed as easily as they’re started.

## License

View [license information](https://github.com/ddev/ddev/blob/master/LICENSE) for the software contained in this image.

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

