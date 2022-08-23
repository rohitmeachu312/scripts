DATE=`date  --rfc-3339=date`

## /tmp/nep/nep/linux_template.csv  file have the headers saperated by ,
cat /tmp/nep/nep/linux_template.csv > /tmp/nep/nep/pne_linux_report_$DATE.csv

	for i in `ls /tmp/nep/nep/linux/`; do
        	cat /tmp/nep/nep/linux/$i >> /tmp/nep/nep/pne_linux_report_$DATE.csv
	done

mkdir -p /tmp/nep/nep/linux_backup/$DATE
mv /tmp/nep/nep/linux/* /tmp/nep/nep/linux_backup/$DATE/


