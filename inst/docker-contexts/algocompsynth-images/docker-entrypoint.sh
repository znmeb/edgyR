#! /usr/bin/env bash

set -e

if [ ${#ALGOCOMPSYNTH_PASSWORD} -ge 12 ]
then
  echo "Resetting 'algocompsynth' password"
  echo "algocompsynth:${ALGOCOMPSYNTH_PASSWORD}" | chpasswd
else
  echo "New 'algocompsynth' password must be at least 12 bytes!"
  echo "Exiting!"
  exit -255
fi
/usr/local/lib/rstudio-server/bin/rserver --server-daemonize 0
