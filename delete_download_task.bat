@echo off

@REM タスクスケジューラから"MyTask"という名前のタスクを削除します
schtasks /delete /tn "MyTask" /f

pause