function Log-Message {
    param (
        [string]$Message,
        [string]$LogFilePath = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\DropBoxSvcRemediationLog.txt"
    )

    # Create the log file if not available
    if (!(Test-Path $LogFilePath)) {
        New-Item -Path $LogFilePath -ItemType File -Force
    }

    # Log the message to the file
    Add-Content -Path $LogFilePath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
}

# Example usage
Log-Message -Message "This is a test massage to log"
