#
# Name:         MO-IN-LINUX-ALL-ROOT-PASSPHRASE-UPDATE
# Module Name:  MO-IN-LINUX-ALL-ROOT-PASSPHRASE-UPDATE
# Function:     RES Script to update root passphrase.
#
# RES Module Parameters:
#   BA      - code to update the root password in encrypted mode.
#   Rev     - Action to take:
#                -swap encrypted root password value
#   InPhase - InUse 
#
# History:
#  Date        Author              Reason
#  ==========  =================== ============================================
#  2020-07-02  Rohit Kumar         Initial version, Approved by peer reviewer
#


#!/bin/bash
oldvalue=`cat /etc/shadow | grep root | awk -F: '$2!~/[*!]/ {print $2}'`
newvalue='$6$NAdET/PH$01t3T1HBK2hBRrQbZJP2gR8393OD8N1al7upPKguBQfxd1HpOuqe.tIcwgcTlDXzWHGjnwtiQM6jyCEFs7Icg0'
echo $oldvalue
echo $newvalue
sed -i "s|$oldvalue|$newvalue|g" /etc/shadow



