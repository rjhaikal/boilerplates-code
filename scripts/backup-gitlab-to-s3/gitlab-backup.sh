#/bin/bash

S3Bucket=`backup-gitlab`
gitlabbackupdate=`date +"%Y%m%d %H:%M"`
TODAY=`date +"%d_%m_%Y"`

echo "========== BACKUP STARTING $gitlabbackupdate =========="

#Delete files older than X Hours
echo "Delete Files Older Than 23 Hours"
find /root/gitlab-backup-old/* -mmin +1380 -exec rm -rf {} \;
find /var/opt/gitlab/backups/* -mmin +1380 -exec rm -rf {} \;

# Backup Start
gitlab-rake gitlab:backup:create

sleep 360

#copy config and secret file to backup directory
cp /etc/gitlab/gitlab.rb /var/opt/gitlab/backups
cp /etc/gitlab/gitlab-secrets.json /var/opt/gitlab/backups

#uploading
echo "upload to NEO Object Storage"
s3cmd sync /var/opt/gitlab/backups/ s3://$S3Bucket/$TODAY/

sleep 120

#move old backup file from default folder to /root/gitlab-backup-old
echo "Move Old Backup file"
find /root/gitlab-backup-old/* -mtime +0 -exec rm -rf {} \;
mv -f /var/opt/gitlab/backups/* /root/gitlab-backup-old

gitlabbackupdate=`date +"%Y%m%d %H:%M"`
echo "========== BACKUP FINISH $gitlabbackupdate =========="
...

chmod +x /root/scripts/gitlab-backup.sh

gitlab-ctl reconfigure
gitlab-ctl restart
gitlab-rake gitlab:check SANITIZE=true

# Additional checks
gitlab-rake gitlab:doctor:secrets
gitlab-rake gitlab:artifacts:check
gitlab-rake gitlab:lfs:check
gitlab-rake gitlab:uploads:check