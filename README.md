# mysql-arm64-images
Build tools for mysql arm64 images

Oracle does not publish any arm64 images for mysql, but people on mac M1 ([ddev](github.com/drud/ddev)) certainly need native images. 

This repo is used for publishing those images.

## Building and pushing

* Push both with ./push.sh in the top-level directory or
* In the proper directory, use `push.sh` to push or `build.sh` to test a build.
* When a new minor version of mysql is released, update the proper base_version.txt
* Note that mysql 8.0 should only be updated to a new minor version *after* the xtrabackup-8.0 version that supports it (that has the same or higher major version)
* xtrabackup-8.0 is built for arm64 in [xtrabackup-build](https://github.com/drud/xtrabackup-build), so you'll need a new release there if a new release for mysql 8.0 comes out, because xtrabackup-8.0 always has to be at least the version of mysql 8.0
* So before updating mysql 8.0, change `files/install/mysql-server`, `files/install/percona-xtrabackup80`, `mysql_version.txt`, and `xtrabackup_version.txt` to the correct versions.
* Then create a new release. The proper tags will be pushed for drud/mysql:5.7 and drud/mysql:8.0

