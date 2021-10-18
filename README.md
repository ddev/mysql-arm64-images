# mysql-arm64-images
Build tools for mysql arm64 images

Oracle does not publish any arm64 images for mysql, but people on mac M1 ([ddev](github.com/drud/ddev)) certainly need native images. 

This repo is used for publishing those images.

## Building and pushing

* Push both with ./push.sh in the top-level directory or
* In the proper directory, use `push.sh` to push or `build.sh` to test a build.
* When a new minor version of mysql is released, update the proper base_version.txt
* Note that mysql 8.0 should only be updated to a new minor version *after* the xtrabackup-8.0 version that supports it (that has the same or higher major version)
