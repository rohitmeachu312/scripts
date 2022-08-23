#!/bin/bash
for i in `cat serverlist.txt`; do
ssh -q -o ConnectTimeout=10 -o StrictHostKeyChecking=no "osadmin"@$i "hostname";
sleep 3
done
