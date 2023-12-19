@echo off
set "hour=%time:~0,2%"
set "minute=%time:~3,2%"
if "%hour:~0,1%"==" " set "hour=0%hour:~1,1%"
set start_time=%hour%:%minute%
schtasks /create /tn "MyTask" /tr "powershell.exe -File .\download_script.ps1" /sc MINUTE /mo 30 /st %start_time% /du 24:00 /ru SYSTEM
pause