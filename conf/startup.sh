#!/bin/bash
/usr/bin/systemctl start nginx
/usr/bin/systemctl start unitd
curl -X PUT -d @/etc/unit/config.json --unix-socket /run/control.unit.sock http://localhost/
