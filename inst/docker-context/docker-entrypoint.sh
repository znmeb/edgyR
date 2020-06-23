#! /usr/bin/env bash

set -e

if [ ${#EDGYR_PASSWORD} -ge 12 ]
then
  echo "Resetting 'edgyr' password"
  echo "edgyr:${EDGYR_PASSWORD}" | chpasswd
else
  echo "New 'edgyr' password must be at least 12 bytes!"
  echo "Exiting!"
  exit -255
fi
/usr/local/lib/rstudio-server/bin/rserver --server-daemonize 0
