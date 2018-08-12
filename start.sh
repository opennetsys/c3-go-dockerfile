#!/bin/bash

#IP="$(/sbin/ip route | awk '/default/ { print $3 }')"
#echo "{ \"insecure-registries\": [ \"$IP:5000\" ] }" | tee /etc/docker/daemon.json && service docker restart

c3-go node start --pem priv.pem --uri /ip4/0.0.0.0/tcp/3330 --data-dir /c3
