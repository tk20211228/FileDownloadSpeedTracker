@echo off
@REM コマンドプロンプトに表示されるエコーをオフにします。これにより、実行中のコマンドが表示されなくなります。

set "hour=%time:~0,2%"
@REM 現在の時間から時を抽出して hour 変数に設定します。%time% 変数は現在の時間を HH:MM:SS.CC 形式（24時間表記）で保持しています。

set "minute=%time:~3,2%"
@REM 現在の時間から分を抽出して minute 変数に設定します。

if "%hour:~0,1%"==" " set "hour=0%hour:~1,1%"
@REM 時が一桁の場合、先頭にスペースが入るので、そのスペースを0に置き換えて二桁の形式に整形します。

set start_time=%hour%:%minute%
@REM hour と minute 変数を結合して start_time 変数を設定します。これはタスクの開始時間として使用されます。

set "current_path=%~dp0"
@REM 現在のバッチファイルのパスを取得して current_path 変数に設定します。

schtasks /create /tn "MyTask" /tr "%current_path%run_download_script.bat" /sc MINUTE /mo 30 /st %start_time% /du 24:00
@REM powershell.exe を実行せず、バッチファイルが格納されているパスに移動します。

@REM /tn..."MyTask"はタスクの名前を指定します。

@REM /tr..."powershell.exe -File.\download_script.ps1"はタスクが実行するコマンドを指定します。

@REM /sc...MINUTE はタスクのスケジュールタイプを分単位で指定します。

@REM /mo...30 はタスクの実行間隔を30分に設定します。

@REM /st...%start_time%はタスクの開始時間を指定します。

@REM /du...24:00 はタスクの期間を24時間に設定します。

@REM /ru...SYSTEM はタスクをシステム権限で実行することを指定します。

pause
@REM バッチファイルの実行が完了した後、ユーザーがキーを押すまでコマンドプロンプトを開いたままにします