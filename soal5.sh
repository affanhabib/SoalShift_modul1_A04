awk '/cron/ || /CRON/ && !/sudo/ && !/SUDO/' /var/log/syslog | awk 'NF < 13' >> /home/aku/Downloads/SoalShift/syslogno5.log
