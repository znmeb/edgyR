#! /bin/bash

set -e

# build L4T images only on Tegra host
if [ `uname -r | grep tegra | wc -l` -le "0" -o `uname -m` != "aarch64" ]
then
  echo "Cannot build - you need to be on an L4T / Tegra host!"
  exit -10
fi

# check the base image
if [ "$1" == "" ]
then
  echo "You need to specify a base image as the first argument,"
  echo "an output image tag as the second argument,"
  echo "and a Dockerfile as the third argument."
  exit -1
fi

# check the output image
if [ "$2" == "" ]
then
  echo "You need to specify a base image as the first argument,"
  echo "an output image tag as the second argument,"
  echo "and a Dockerfile as the third argument."
  exit -2
fi

# check the Dockerfile
if [ "$3" == "" ]
then
  echo "You need to specify a base image as the first argument,"
  echo "an output image tag as the second argument,"
  echo "and a Dockerfile as the third argument."
  exit -3
fi

# check the repository definition
if [ "$DOCKER_REPO" == "" ]
then
  echo "You need to define the 'DOCKER_REPO' environment variable"
  echo "to fully tag the image!"
  exit -20
fi

echo "Building the image"
/usr/bin/time sudo docker build \
  --build-arg BASE_IMAGE="$1" \
  --build-arg R_SOURCE_TARBALL="https://cloud.r-project.org/src/base/R-4/R-4.0.2.tar.gz" \
  --build-arg RSTUDIO_VERSION_MAJOR=1 \
  --build-arg RSTUDIO_VERSION_MINOR=3 \
  --build-arg RSTUDIO_VERSION_PATCH=959 \
  --tag="$2" \
  --file="$3" \
.

sudo docker tag "$2" "$DOCKER_REPO/$2"
sudo docker images
