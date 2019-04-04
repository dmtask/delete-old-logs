#!/bin/bash

# Löscht einmal im Monat alte Logs (*.gz)

logs="/var/log/ /var/log/mysql/ /var/log/clamav/ /var/log/apache2/"
tempFileForInfos="/tmp/tempFileForInfos.txt"
sendMail=true

echo -n "Folgende Dateien wurden durch den Log-GC entfernt:\n\n" > ${tempFileForInfos}

for log in ${logs}
do
        cd "${log}"

        #if [ -s $(ll *.gz) ]; then
                rm -v *.gz >> ${tempFileForInfos}
        #fi
done

sleep 0.5
if $sendMail; then
        mail -a "From: Log-Checker <servermails@eoceo.de>" -s "Log-GC (~/cronjobs/deleteOldLogs.sh)" dm@eoceo.de < ${tempFileForInfos}
fi
