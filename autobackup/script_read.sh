#!/bin/bash
# Author: Clara Savelli - clara.15is.cs@gmail.com
#
# --------------------------------------------------------------

# emails configs
gmail_from="systemtecno8@gmail.com"
gmail_pwd="lperqdnxtlhqbilk"
gmail_to="clara.15is.cs@gmail.com"

hostname=`hostname -I`
backup_date=`date --date='-1 day' +%Y-%m-%d` # yesterday
database='FOSPUCA_MAIN'
path='/backups'

# delete before files
find $path -type f -prune -mtime +7 -exec rm -f {} \;

# send info to email
echo -e "Subject: Recepcion de Autobackup en el servidor $hostname \n" > mail.txt

if [ -f $path$database\_$backup_date.sql ]
then
    echo -e "Backup de $path$database\_$backup_date.zip Recibido correctamente en el servidor $hostname\n" >> mail.txt
else
    echo -e "Backup de $path$database\_$backup_date.zip No se ha encontrado en el servidor $hostname\n" >> mail.txt
fi
