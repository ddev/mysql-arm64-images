# mysql-arm64-images
Build tools for mysql arm64 images

Oracle does not publish any arm64 images for mysql, but people on mac M1 ([ddev](github.com/ddev/ddev)) certainly need native images. 

This repo is used for publishing those images.

## Preparation

Because mysql-server-8.0 is usually ahead of the released xtrabackup version, it's important to capture the mysql-server and mysql-client deb files ahead of time, when we're expecting a new xtrabackup version.

To do this, for both PLATFORM=linux/amd64 and PLATFORM=linux/arm64, `docker run -it --platform=$PLATFORM --rm ubuntu:20.04 bash` and `apt update && apt upgrade -y && apt install -y mysql-server` and then remove all that with `apt remove mysql-server mysql-client && apt autoremove`. This should put the system in position where the exact needed items will be downloaded with `apt install -y --download-only mysql-server-8.0`, after which all the need .deb files will be in /var/cache/apt/archives and they can be updated into the replacement of mysql-8.0.31

## Building and pushing

* Push both with ./push.sh in the top-level directory or
* In the proper directory, use `push.sh` to push or `build.sh` to test a build.
* When a new minor version of mysql is released, update the proper base_version.txt
* Note that mysql 8.0 should only be updated to a new minor version *after* the xtrabackup-8.0 version that supports it (that has the same or higher major version)
* xtrabackup-8.0 is built for arm64 in [xtrabackup-build](https://github.com/ddev/xtrabackup-build), so you'll need a new release there if a new release for mysql 8.0 comes out, because xtrabackup-8.0 always has to be at least the version of mysql 8.0
* So before updating mysql 8.0, change `files/install/mysql-server`, `files/install/percona-xtrabackup80`, `mysql_version.txt`, and `xtrabackup_version.txt` to the correct versions.
* Then create a new release. The proper tags will be pushed for ddev/mysql:5.7 and ddev/mysql:8.0

