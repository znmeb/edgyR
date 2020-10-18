#! /usr/bin/env bash

set -e

if [ ${#EDGYR_PASSWORD} -lt 12 ]
then
  echo "New 'edgyr' password must be at least 12 characters!"
  echo "Exiting!"
  exit -255
fi
echo "Resetting 'edgyr' password"
echo "edgyr:${EDGYR_PASSWORD}" | chpasswd
export RSTUDIO_PORT=`grep www-port /etc/rstudio/rserver.conf | sed 's/^www-port=//'`
echo "Starting RStudio Server - browse to http://edgyr:$RSTUDIO_PORT"
/usr/local/lib/rstudio-server/bin/rserver --server-daemonize 0
