import os
import tarfile
import datetime

BackupFolder = "/nfsbackup/amp_backups/"
TargetFolder = "/home/amp/.ampdata/instances/"
CurrentDate = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")

Folders = os.listdir(TargetFolder)

for Folder in Folders:
    print(f'Processing: {Folder}')
    if ".zip" not in Folder:
        if Folder in os.listdir(BackupFolder):
            print(f'Folder: {Folder} already exists')
        else:
            os.makedirs(BackupFolder + Folder)
            print(f'Folder: {Folder} created')
        BackupPath = f'Archiving {Folder} to {BackupFolder}{Folder}/{Folder}_{CurrentDate}.tar.gz'
        SourceFolder = f'{TargetFolder}{Folder}'
        print(f'Archiving {Folder} to {BackupPath}')
        with tarfile.open(f'{BackupFolder}{Folder}/{Folder}_{CurrentDate}.tar.gz', "w:gz") as tar :
            tar.add(SourceFolder)
        print(f'Archiving {Folder} complete')
