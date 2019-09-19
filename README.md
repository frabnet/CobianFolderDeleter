# CobianFolderDeleter

This simple script helps you to delete old folders when Cobian Backup don't delete them.
**NOTE:** This script is tested on PowerShell 4 or greater. You can download v4 from [Microsoft website](https://www.microsoft.com/en-us/download/details.aspx?id=40855).

## Why

When Cobian Backup is set to keep only the last X copies, but the destination disk is changed (for example a USB HDD that is swapped every week), Cobian can't find old folders in the disconnected HDD, so "Trash" starts to accumulate and eventually the disk will be full.

## Use scenario

**WARNING**: This script is tested only to work with Cobian Backup and a backup destination structured *exactly* like this:

```
produzione 2017-03-06
produzione 2017-03-07
produzione 2017-03-08
produzione 2017-03-09
test 2017-01-01
test 2017-01-02
test 2017-01-03
test 2017-01-05
test 2017-01-04
```

## Command line parameters

**-RootFolder** self explanatory, if folder contains spaces please use quotes\
**-Keep** number of most recent folders to keep\
**-Run** if not specified, the script will just display deletions and not delete anything\

## How to run

Run this command on Cobian Backup before or after backup execution as you like.

```
c:\windows\system32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -Executionpolicy Bypass -File "deleter.ps1" -RootFolder W: -Keep 3 -Run
```

Since this is really long command line, you may copy all this in a .cmd file and run only that from Cobian.