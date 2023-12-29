# $PSScriptRootを使用して、スクリプトのあるディレクトリにログファイルパスを作成
$logPath = Join-Path -Path $PSScriptRoot -ChildPath "log.csv"
$errorLogPath = Join-Path -Path $PSScriptRoot -ChildPath "error_log.txt"


function Initialize-Log {
    if (-not (Test-Path -Path $logPath)) {
        $header = "Timestamp,Downloaded File Name,Total Downloaded Time (seconds),Downloaded File Size (bytes),Average Speed (bytes/sec),Status,Error Message"
        $header | Out-File -FilePath $logPath -Encoding ASCII
    }
}

function Write-ErrorLog {
    param (
        [string]$errorMessage
    )

    Add-Content -Path $errorLogPath -Value $errorMessage -Encoding ASCII
}

function Get-FileFromUrl {
    param (
        [string]$url
    )

    $start_time = Get-Date
    try {
        $downloaded_file = Invoke-WebRequest -Uri $url
        $filename = [System.IO.Path]::GetFileName($downloaded_file.BaseResponse.ResponseUri.LocalPath)
        $downloaded_file_size = $downloaded_file.BaseResponse.ContentLength
        $status = "Success"
        $errorMessage = $null
        
    } catch {
        $filename = $null
        $downloaded_file_size = 0
        $status = "Failed"
        $errorMessage = $_.Exception.Message
    }
    $end_time = Get-Date

    $total_time = $end_time - $start_time
    $average_speed = if ($total_time.TotalSeconds -gt 0) { $downloaded_file_size / $total_time.TotalSeconds } else { 0 }

    return @{
        StartTime = $start_time.ToString();
        DownloadedFileName = $filename;
        TotalDownloadTime = $total_time.TotalSeconds;
        DownloadedFileSize = $downloaded_file_size;
        AverageSpeed = $average_speed;
        Status = $status;
        ErrorMessage = $errorMessage;
    }
}
function Write-Log {
    param (
        [hashtable]$logData
    )

    try {
        $log = "$($logData.StartTime),$($logData.DownloadedFileName),$($logData.TotalDownloadTime),$($logData.DownloadedFileSize),$($logData.AverageSpeed),$($logData.Status),$($logData.ErrorMessage)"
        Add-Content -Path $logPath -Value $log -Encoding ASCII
    } catch {
        $errorMessage = $_.Exception.Message
        Write-ErrorLog -errorMessage $errorMessage
    }
}
# メインの処理
. $PSScriptRoot\config.ps1  # $PSScriptRootを使用してconfig.ps1のパスを指定

Initialize-Log
$logData = Get-FileFromUrl -url $env:DOWNLOAD_URL -filename $env:FILE_NAME
Write-Log -logData $logData