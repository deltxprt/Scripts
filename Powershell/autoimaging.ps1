$target="\\10.0.0.9\Backups" #drive letter/path or network drive IP and path
wbadmin start backup -backupTarget:$target -include:C: -quiet -allCritical