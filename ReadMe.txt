ReadMe:

Introduction:
Home Assistant (HA) config files daily auto backup with their check-sums using a simple shell script. Intended for the basic users who want to keep HA config files safe, 
these files are mostly improvised manually with higher granularity; there are chances of mistakes or deletion and this will ease the process of recovery or save you from
complete misery. This script backs up files defined in "/backup/daily/config.files" configuration file with their relative path. The script throws an error message if the
file path is not found and it doesn't process such missing references. Lastly, this is fully tested in standard HA installations.

Instructions:
a. Install "Advanced SSH and Terminal Application" add-on if you haven't done so
b. Open the web interface of installed add-on Terminal Application
c. Create directories: mkdir -p /backup/daily/files
d. Download and place the backup.sh and config.files in /backup/daily directory (by default it backs up most common files: configuration.yaml, scerets.yaml, lovelace, and automations.yaml), you may add more based on your need
e. Change the config.files with their relative paths (if you want to add more files), note: script won't work if not configured with full path, follow the example from the given default configurations
f. Go back to Advanced SSH and Terminal Application add-on, "Configuration" and at "Init_commands" section paste the following lines:
   "if ! pgrep -x "crond" > /dev/null; then echo starting crond; cp /root/backup/daily/backup.sh /etc/periodic/daily; crond -b -l 5 -L /var/log/crond.log; fi"
g. Restart the Advanced SSH and Terminal Application add-on

Validation (post 'add-on' restart):
i. Open Terminal and execute command: "pgrep -x crond" should return a value
ii. Manually run the backup: "/backup/daily/backup.sh" followed by "ls -ltra /backup/daily/files", you will see the list of files backup with their checksum and date
iii. Command: "more /etc/periodic/daily/backup.sh", If you're able to see the output of the script, implementation is successful, and the backup will be done every morning 2 am
