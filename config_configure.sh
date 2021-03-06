#!/bin/bash

export LC_ALL=C

screen -d -m -S router mongos --port $port --configdb $config_softfire_internal_floatingIp:$config_port

nproc=`sudo netstat -tulpn | grep $port | wc -l`

COUNTER=1
while [ 1 -eq "$nproc" ]; do
  COUNTER=$(($COUNTER + 1))

  sleep 5 # wait for 1/10 of the second before check again
  if [ 100 -eq $COUNTER ]; then
    echo "mongodb not started"
    exit 99
  fi
done
echo "mongodb router is running"

# .....
sleep 2
