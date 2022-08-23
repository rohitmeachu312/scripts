#!/bin/bash
for i in `cat serverlist.txt`; do
/home/c67336/sshpass -p '!QAZxsw2#EDCvfr4' ssh -q -o ConnectTimeout=10 -o StrictHostKeyChecking=no "c67336a"@$i "echo "--------------------------------------------------------------------------------------------------";hostname;echo "...../opt/IBM/TWS/bin/JobManager.....";ls /opt/IBM/TWS/bin/ | grep -i JobManager;echo "...../opt/IBM/properties/version/TWS_Agent*.....";ls /opt/IBM/properties/version | grep -i TWS_Agent;ps -ef | grep -i tws | grep -v grep | wc -l;" >> /tmp/tws_restarted.txt
sleep 3
done

