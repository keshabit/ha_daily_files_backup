# This script is created by keshabit to backup and save files that need frequent improvisions in the Home Assistant
#!/bin/bash
_loc="/root/backup/daily/files/"
while read -r _line
do 
  if [ -f "$_line" ]
  then
    _file=`echo $_line |awk -F "/" '{print $NF}'`
    cks=`cksum $_line| awk '{print $1}'` 
    cp $_line $_loc$_file.$cks.$(date +"%Y%m%d")
  else
    echo "Error: File $_line is not found!"
  fi
done < "/backup/daily/config.files"

# 30 days old backup auto cleanup
find $_loc -name "*.20*" -type f -mtime +30 -exec rm {} \;
