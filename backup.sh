###################################################
#        Basic backup script by Keshab            #
###################################################
#!/bin/bash
#-------------------------------------------------
_loc="/backup/hourly/files/"
#-------------------------------------------------
while read -r _line
do 
  if [ -f "$_line" ]
  then
    _file=`echo $_line |awk -F "/" '{print $NF}'`
    cks=`cksum $_line| awk '{print $1}'` 
    cp $_line $_loc$_file.$cks
  else
    echo "Error: File $_line is not found!"
  fi
done < "/backup/hourly/config.files"
##################################################
# 30 days old backup files auto cleanup
#------------------------------------------------
find $_loc -type f -mtime +30 -exec rm {} \;
##################################################
