# ddev/mysql-arm64-images docker images (ddev/ddev-mysql)

## Overview

Build tools for mysql arm64 images

Oracle does not publish any arm64 images for mysql, but people on Apple Silicon (DDEV) certainly need native images.

This repo is used for publishing those images, and is used and `ddev/ddev-dbserver-mysql-5.7`

NOTE: As of 2024-12 we are using the Bitnami images for mysql:8.0+, so do not need to build or push images for `ddev/mysql:8.0`. And Percona is now publishing ARM64 versions of `percona-xtrabackup`, so we no longer have to build our own. As a result, this README is being updated, but earlier git versions will still show how it was done.

### Features

These images are built on upstream Ubuntu.

## Building and pushing

* Push the 5.7 image with `cd 5.7 && ./push.sh`.
* If a new minor version of mysql is released, update the proper base_version.txt


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

