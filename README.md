# FileDownloadSpeedTracker

このプロジェクトは、指定されたURLからファイルをダウンロードし、ダウンロードにかかった時間と速度をCSVファイルに記録するPowerShellスクリプトを含んでいます。また、タスクスケジューラーを使用して定期的にスクリプトを実行するバッチファイルも含まれています。

以下に、各ファイルの詳細と使用方法を示します。

### config.ps1
このプロジェクトの設定を行うための手順は以下の通りです：

1. このプロジェクトをクローンします。
2. `config_default.ps1`を`config.ps1`にリネームします。
3. `config.ps1`にダウンロードしたいファイルのURLを設定します。例えば：
```powershell
$env:DOWNLOAD_URL = "https://example.com/sample.zip"
```

### download_script.ps1

このスクリプトは、指定されたURLからファイルをダウンロードし、ダウンロードの詳細をログファイルに保存します。ログファイルには、ダウンロードしたファイルの名前、ダウンロードにかかった時間、ダウンロードしたファイルのサイズ、平均ダウンロード速度、ダウンロードのステータス、エラーメッセージが記録されます。

### create_download_task.bat

このバッチファイルは、タスクスケジューラーに新しいタスクを作成します。このタスクは、30分ごとにdownload_script.ps1を実行します。

### delete_task.bat

このバッチファイルは、タスクスケジューラーから"MyTask"という名前のタスクを削除します。

以上がこのプロジェクトの内容と各ファイルの使用方法です。123