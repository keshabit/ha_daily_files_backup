ReadMe:
Home Assistant (HA) config files hourly auto backup with their checksums using a simple shell script. This will only backup the latest copy of the unchanged file(s) and 
multiple copies of changed files hourly. Intended for the basic users who want to keep HA config files safe, these files are mostly improvised manually with higher 
granularity; there are chances of mistakes or deletions and this will ease the process of recovery or save you from complete misery. This script works with the "Advanced
SSH and Terminal Application" (AS&T) add-on. This script saves the files defined in the "/backup/hourly/config.files" configuration file with their relative path. The 
script throws an error message if the file path is not found and it doesn't process such missing references. The script auto-cleans the files older than 30 days.

Test Setup:
Home Assitant Versions
Core: 2024.9.1
Supervisor: 2024.08.0
Operating System: 13.1
Frontend: 20240906.0

Advanced SSH and Terminal Application
version: 18.0.0

Instructions:
a. Install the "Advanced SSH and Terminal Application" add-on if you haven't done so
b. Open the web interface of the installed add-on
c. Create directories: mkdir -p /backup/hourly/files
d. Download and place the backup.sh and config.files in /backup/hourly directory (by default it backs up most common files: configuration.yaml, scerets.yaml, lovelace, and 
   automations.yaml), you may add more based on your need
e. Change the config.files with their relative paths (if you want to add more files), note: script won't work if not configured with full path, follow the example from the 
   given default configurations
f. Go back to Advanced SSH and Terminal Application add-on, "Configuration" and at "Init_commands" section paste the following lines:
   "if ! pgrep -x "crond" > /dev/null; then echo starting crond; cp /root/backup/hourly/backup.sh /etc/periodic/hourly; crond -b -l 5 -L /var/log/crond.log; fi"
g. Restart the Advanced SSH and Terminal Application add-on

Validation (post 'add-on' restart):
i. Open Terminal and execute command: "pgrep -x crond" should return a value
ii. Manually run the backup: "/backup/hourly/backup.sh" followed by "ls -ltra /backup/hourly/files", you will see the list of files backup with their checksum and date
iii. Command: "more /etc/periodic/hourly/backup.sh", If you're able to see the output of the script, implementation is successful, and the backup will be done every hour
