#!/bin/bash
# Author: Clara Savelli - clara.15is.cs@gmail.com
#
# Requirements:
# sudo apt install gsutil
# sudo apt install vim
# --------------------------------------------------------------

# Name of Bucket in Google Cloud Storage
google_bucket="conflux-backups"

# paths
backup_dir="/odoo/backups/"
filestore="/odoo/.local/share/Odoo/filestore/"

# emails configs
gmail_from="correo_saliente@gmail.com"
gmail_pwd="key_correo_saliente"
gmail_to="clara.15is.cs@gmail.com"

# host destinity
host_to='10.160.56.10'
ftp_user='user_server_ftp'
path_to='/backups'

hostname=`hostname -I`
backup_date=`date +%Y-%m-%d`
database='BASE_DE_DATOS'

number_of_days=3
echo -e "Subject: Resultado de Autobackup \n" > mail.txt
echo -e "Resultado de Backup realizado en el servidor $hostname: \n\n" >> mail.txt
  
echo Dumping $database to $backup_dir$database\_$backup_date.sql
pg_dump $database > $backup_dir$database\_$backup_date.sql
#zipping sql
zip -r -D $backup_dir$database\_$backup_date.zip $backup_dir$database\_$backup_date.sql $filestore$database

# subiendo a google cloud
# TODO: no funciona, revisar Google Cloud Storage
# gsutil cp $backup_dir$i\_$backup_date.zip $google_bucket
#printing file size to mail

# send by ftp server
rsync -avz $backup_dir$database\_$backup_date.zip -avz $ftp_user@$host_to:$path_to

file_size=$(du -m $backup_dir$database\_$backup_date.zip | cut -f1)
echo -e "Backup de $backup_dir$database\_$backup_date.zip $file_size MB Realizado correctamente \n" >> mail.txt


# eliminando archivos antiguos
find $backup_dir -type f -prune -mtime +$number_of_days -exec rm -f {} \;

# ahora enviamos mail de ejecucion correcta
curl --url 'smtps://smtp.gmail.com:465' --ssl-reqd --mail-from $gmail_from --mail-rcpt $gmail_to --upload-file mail.txt --user $gmail_from:$gmail_pwd >


