#! /bin/bash

set -e

# build L4T images only on Tegra host
if [ `uname -r | grep tegra | wc -l` -le "0" -o `uname -m` != "aarch64" ]
then
  echo "Cannot build - you need to be on an L4T / Tegra host!"
  exit -10
fi

# check the output image
if [ "$1" == "" ]
then
  echo "You need to specify an output image tag as the first argument,"
  echo "and a Dockerfile as the second argument."
  exit -1
fi

# check the Dockerfile
if [ "$2" == "" ]
then
  echo "You need to specify an output image tag as the first argument,"
  echo "and a Dockerfile as the second argument."
  exit -2
fi

echo "Building the image"
/usr/bin/time sudo docker build \
  --build-arg ARROW_TARBALL="https://github.com/apache/arrow/archive/apache-arrow-1.0.1.tar.gz" \
  --build-arg DEBIAN_FRONTEND="noninteractive" \
  --build-arg EDGYR_HOME="/home/edgyr" \
  --build-arg EDGYR_LOGFILES="/home/edgyr/logfile"s \
  --build-arg \
    JULIA_TARBALL="https://julialang-s3.julialang.org/bin/linux/aarch64/1.5/julia-1.5.2-linux-aarch64.tar.gz" \
  --build-arg PACKAGE_FILE="rstudio-server-1.3.1093-arm64.deb" \
  --build-arg PAPERSIZE="letter" \
  --build-arg PROJECT_HOME="/home/edgyr/Projects" \
  --build-arg R_PACKAGE_REPO="/usr/local/src/r-package-repo" \
  --build-arg RSTUDIO_VERSION_MAJOR="1" \
  --build-arg RSTUDIO_VERSION_MINOR="3" \
  --build-arg RSTUDIO_VERSION_PATCH="1093" \
  --build-arg SOURCE_DIR="/usr/local/src" \
  --build-arg WORKON_HOME="/home/edgyr/.virtualenvs" \
  --tag="$1" \
  --file="$2" \
.

sudo docker system prune -f
sudo docker images
