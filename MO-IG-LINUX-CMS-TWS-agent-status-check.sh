#
# Name:         MO-IG-LINUX-CMS-TWS-agent-status-check.sh
# Module Name:  MO-IG-LINUX-CMS-TWS-agent status check
# Function:     RES Script to check only TWS agent status – running /installed/not running.
#
# RES Module Parameters:
#   BA      - 16 line code to check the installation files and agent status on server.
#   Rev     - Action to take:
#                -Check file location
#		 -Check installed status
#		 -Print result
#   InPhase - InUse 
#
# History:
#  Date        Author              Reason
#  ==========  =================== ============================================
#  2020-04-23  Rohit Kumar       Initial version, Approved by peer reviewer
#

#!/bin/bash
# Checks for TWS agent
if [ -f   /opt/IBM/TWS/ITA/cpa/ita/agent ] && [ -f  /opt/IBM/TWS/bin/JobManager ]
then
  RUNNING_PROCESS=`ps -ef | grep -i tws | grep -v grep | wc -l`
  if [ $RUNNING_PROCESS -ge 1 ]
  then
   echo "TWS Agent is installed  and running on `uname -n`"
  else
     echo "TWS Agent is installed and not running on `uname -n`"
  fi
else
   echo "TWS Agent not installed on `uname -n`"
fi



