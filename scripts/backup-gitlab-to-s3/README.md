# Gitlab Backup Script

Prerequisites:

- s3 bucket
- s3cmd configured

## Backup

1. Install and Configure s3cmd

```
apt install s3cmd
s3cmd --configure
```

2. Add a cron job

```
# Pukul 18 UTC > Pukul 1 GMT
0 18 * * * bash /root/scripts/gitlab-backup.sh >> /var/log/gitlab/gitlab-backup.log 2>&1
```

## Restore

1. Preparing Files

```
ls

1646492967_2022_03_05_14.6.0_gitlab_backup.tar
gitlab-secrets.json
gitlab.rb.orig
```

2. Replace secret and main configuration file

```
mv /etc/gitlab/gitlab-secrets.json /etc/gitlab/gitlab-secrets.json.backup
mv /etc/gitlab/gitlab.rb /etc/gitlab/gitlab.rb.orig
mv gitlab.rb /etc/gitlab/
mv gitlab-secrets.json /etc/gitlab/
```

3. Move backup file

```
cp backups/1646492967_2022_03_05_14.6.0_gitlab_backup.tar /var/opt/gitlab/backups
chown git.git /var/opt/gitlab/backups/1646492967_2022_03_05_14.6.0_gitlab_backup.tar
```

4. Stop services which related to database

```
gitlab-ctl stop puma
gitlab-ctl stop sidekiq
```

5. Restore

```
cd /var/opt/gitlab/backups/
gitlab-backup restore BACKUP=1646492967_2022_03_05_14.6.0_gitlab_backup.tar
```

6. Start all services

```
gitlab-ctl restart
```