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
  --tag="$1" \
  --file="$2" \
.
