function IsProcessRunni {
    param (
        [string]$processName
    )

    # Check if a process with the given name is running
    if (Get-Process -Name $processName -ErrorAction SilentlyContinue) {
        Write-Host "$processName is running."
        return $true
    } else {
        Write-Host "$processName is not running."
        return $false
    }
}

# Example usage
$processName = "dropbox"
$isRunning = Get-ProcessStatus -processName $processName

# Output
Write-Host "Is process running? $isRunning"
