#!/bin/bash

cat /var/log/syslog | awk '(/!sudo/ || /cron/ && /CRON/) && (NF<13){print}' > /home/affan/modul1/syslog.log
