#!/bin/bash
/usr/sbin/nginx
/usr/sbin/unitd
curl -X PUT -d @/etc/unit/config.json --unix-socket /run/control.unit.sock http://localhost/

while true
do
    sleep 10
done
