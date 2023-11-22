function Uninstall-Service {
    param (
        [string]$uninstallerPath
    )

    try {
        # Check if the uninstaller path exists
        if (Test-Path $uninstallerPath -PathType leaf) {
            Start-Process -FilePath $uninstallerPath -ArgumentList '/S' -Wait
            LogMessage "Uninstallation completed successfully."
        } else {
            LogMessage "Experiencing issues with uninstalling. Uninstaller not found at: $uninstallerPath"
        }
    } catch {
        LogMessage "Failed to uninstall."
    }
}

# Usage example:
$uninstallerPath = 'C:\Program Files (x86)\Dropbox\Client\DropboxUninstaller.exe'
Uninstall-Service -uninstallerPath $uninstallerPath
