# Notify Script when SSH

## How To Use

1. Create Directory

```
mkdir /opt/alert-ssh-remote && cd /opt/alert-ssh-remote
```

2. Copy alert.sh and credentials.config
3. Edit credentials.config

```
# Your USERID or Channel ID to display alert and key, we recommend you create new bot with @BotFather on Telegram

USERID=( {GROUP_ID} )
KEY="{BOT_TOKEN}"
```
    Change `GROUP_ID` to your telegram group id and `BOT_TOKEN` to your bot token.

4. Create script on /etc/profile.d/ directory

```
nano /etc/profile.d/telegram-alert.sh

---
# CREATE THIS FILE ON /etc/profile.d/telegram-alert.sh
#!/usr/bin/env bash
# Log connections
bash /opt/alert-ssh-remote/alert.sh
---
```