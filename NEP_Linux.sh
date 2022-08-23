#
# Name:         NEP_report_Linux
# Module Name:  NEP report for Linux
# Function:     Script for creating a report of accounts with a NEP Linux
#
# History:
#  Date        Author              Reason
#  ==========  =================== ============================================
#  2021-03-03  Jeroen Visser       Initial version
#  2022-02-15  Jeroen Visser
#

# Determine OS type
OS_TYPE=$(uname)
if [ "$OS_TYPE" == "Linux" ]; then
	Platform=$(uname -a | awk {'print $1'})
	System=$(cat /etc/redhat-release)
	Hostname=$(hostname -f)
        DATE=$(date +"%Y-%m-%d")
	> /tmp/$Hostname-$DATE.csv
	if ls /etc/pam.d/system-auth > /dev/null
	then
		PamEnabled="enabled"
	else
		PamEnabled="disabled"
	fi
	for i in $(cat /etc/passwd | cut -d: -f1)
	do
		Password_Max_Age=$( chage -l $i | grep -i "Maximum" | awk {'print $NF'})
		if [ ${Password_Max_Age} -gt 90 ] || [ ${Password_Max_Age} -lt 1 ]
		then
			PWD=$( cat /etc/shadow | grep ^$i: | cut -d ":" -f 2) 
			if [ "$PWD" == "!!" ] || [ "$PWD" == "!" ] || [ "$PWD" == "*" ] || [ "$PWD" == "!*" ]; then
				Is_NEP="No"
			else
				Username=$i
				Gecos=$(cat /etc/passwd | grep ^$i: | sed -e s/\;/" "/g | cut -d: -f5)
				Is_NEP="Yes"
				if  passwd --status $i |awk {'print $2'} | grep LK > /dev/null 2>&1
				then
					IsAccountActive=no
				else
					IsAccountActive=yes
				fi
				Shell=$(cat /etc/passwd |grep ^$i: | sed -e s/\;/" "/g | cut -d: -f7)
				if ls /etc/ftpusers >/dev/null 2>&1
				then
					if grep $i /etc/ftpusers
					then
						FTP="enabled"
					fi
				elif ls /etc/vsftpd/ftpusers >/dev/null 2>&1
				then
					if  grep $i /etc/vsftpd/ftpusers
					then
						FTP="enabled"
					fi
				else
					FTP="disabled"
				fi

				if [ "$Shell" == "/sbin/nologin" ] || [ "$Shell" == "/bin/false" ] || [ "`id $i | grep no-ssh-login`" ]; then
					RLogin="No"
				else
					RLogin="Yes"
				fi
				if [ "$Shell" == "/sbin/nologin" ] || [ "$Shell" == "/bin/false" ] || [ "$PamEnabled" == "disabled" ]; then
					Login="No"
				else
					Login="Yes"
				fi
				echo \"$Hostname\",\"$Username\",\"$Gecos\",\"$IsAccountActive\",\"$Login\",\"$RLogin\",\"$Platform\",\"$System\",\"$Shell\",\"$FTP\" >> /tmp/$Hostname-$DATE.csv
				
			fi
		fi
	done
fi

