#!/bin/bash
systemctl start unitd
sleep 5
curl -X PUT -d @/etc/unit/config.json --unix-socket /run/control.unit.sock http://localhost/
