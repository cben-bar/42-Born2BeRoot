#!/bin/bash
echo ‘#Architecture:’ `uname -a`
echo ‘#CPU physical :’ `cat /proc/cpuinfo | grep “physical id” | sort | uniq | wc -l`
grep ^cpu\\scores /proc/cpuinfo | uniq |  awk ‘{print “#vCPU : ” $4}’
free -m | awk ‘NR==2{printf “#Memory Usage: %s/%sMB (%.2f%%)\n”, $3,$2,$3*100/$2 }’
df -h | awk ‘$NF==”/”{printf “#Disk Usage: %d/%dGB (%s)\n”, $3,$2,$5}’
echo ‘#CPU load:’ `cat /proc/loadavg`
echo ‘#Last reboot:’ `who -b`
if [ -f “/sbin/lvdisplay” ]; then
        echo “#LVM use: yes”;
else
        echo “#LVM use: no”;
fi
echo ‘#Connexions TCP UDP:’ `netstat -ntu | grep ESTAB | awk ‘{print $5}’ | cut -d: -f1 | sort | uniq -c | sort -nr | wc -l` ‘ ESTABLISHED ’

