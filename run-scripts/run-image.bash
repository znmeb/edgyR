#! /bin/bash

# run L4T images only on Tegra host
if [ `uname -r | grep tegra | wc -l` -le "0" -o `uname -m` != "aarch64" ]
then
  echo "Cannot run - you need to be on an L4T / Tegra host!"
  exit -10
fi

# check the image
if [ "$1" == "" ]
then
  echo "You need to specify a Docker image as the first argument,"
  echo "and a password for the 'edgyr' account as the second argument."
  echo "The new 'edgyr' password must be at least 12 characters!"
  exit -1
fi

# check the password
if [ ${#2} -lt 12 ]
then
  echo "You need to specify a Docker image as the first argument,"
  echo "and a password for the 'edgyr' account as the second argument."
  echo "The new 'edgyr' password must be at least 12 characters!"
  exit -2
fi

echo "Force-removing old 'edgyr' container"
echo "You can ignore errors if it doesn't exist"
sudo docker rm -f edgyr
echo "Running image $1"
sudo docker run --detach \
  --env EDGYR_PASSWORD=$2 \
  --network host --name edgyr --hostname edgyr \
  --runtime nvidia \
  "$1"

sleep 5
sudo docker ps
sudo docker logs edgyr
