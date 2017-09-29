#!/bin/bash
systemctl start unitd
curl -X PUT -d @/etc/unit/config.json --unix-socket /run/control.unit.sock http://localhost/
