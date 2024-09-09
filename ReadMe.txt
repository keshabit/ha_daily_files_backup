ReadMe:
Introduction:
HA config files daily auto backup with their checksums using a simple shell script
These files are mostly manually configured files; there are chances of mistaken deletion and this will ease the process of recovery or save you from misery
This script backs up files defined in "/backup/daily/config.files" configuration file with their relative path
Throws an error message if file is not found and it doesn't process such files
This is fully tested in standard HA installations

Instructions:
Install "Advanced SSH and Terminal Application" add-on if you haven't done so
Open the web interface of installed add-on Terminal Application
Create directories: mkdir -p /backup/daily/files
Download and place the backup.sh and config.files in /backup/daily directory (by default it backs up most common files like: configuration.yaml, scerets.yaml, lovelace, and automation.yaml), you may add more based on your need
Change the config.files with their relative paths, note: script wont work if no relative path is provided, follow example from default configuration
Go back to Advanced SSH and Terminal Application add-on, "Configuration" and at "Init_commands" section paste the following lines:
if ! pgrep -x "crond" > /dev/null; then echo starting crond; cp /root/backup/daily/backup.sh /etc/periodic/daily; crond -b -l 5 -L /var/log/crond.log; fi
Restart the Advanced SSH and Terminal Application add-on

Validation (post add-on restart):
Open Terminal and execute command: "pgrep -x crond" should return a value
Manually run the backup: "/backup/daily/backup.sh" followed by "ls -ltra /backup/daily/files", you will see the list of files backup with their checksum and date
Command: "more /etc/periodic/daily/backup.sh" if you're able to see the output of script, implementation is successful, and the backup will be done every 2 am