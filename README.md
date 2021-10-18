# mysql-arm64-images
Build tools for mysql arm64 images

Oracle does not publish any arm64 images for mysql, but people on mac M1 ([ddev](github.com/drud/ddev)) certainly need native images. 

This repo is used for publishing those images.

## Building and pushing

* Push both with ./push.sh in the top-level directory or
* In the proper directory, use `push.sh` to push or `build.sh` to test a build.
* When a new minor version of mysql is released, update the proper base_version.txt
* Note that mysql 8.0 should only be updated to a new minor version *after* the xtrabackup-8.0 version that supports it (that has the same or higher major version)
* So before updating mysql 8.0, change the xtrabackup-8.0/base_version.sh to a matching version and get a new one built.

## Building xtrabackup-8.0

The build script for xtrabackup-8.0 was patterned on [Compiling Percona Xtrabackup for ARM](https://www.percona.com/blog/2021/04/28/compiling-percona-xtrabackup-for-arm/) (Thanks!) and is intended for use on an arm64 Ubuntu 20.04 machine. You can just run the `build.sh` to build it, after choosing the version you want in `xtrabackup-8.0/base_version.txt`.
