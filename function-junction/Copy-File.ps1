function Copy-CsUninstallTool {
    param (
        [string]$sourceFilePath,
        [string]$destinationFolder
    )

    # Check if the source file exists
    if (-not (Test-Path $sourceFilePath)) {
        Write-Host "Source file $sourceFilePath does not exist."
        return 1
    }

    # Check if the destination folder exists; if not, create it
    if (-not (Test-Path $destinationFolder -PathType Container)) {
        New-Item -ItemType Directory -Path $destinationFolder -Force
    }

    # Get the base file name from the source file path
    $fileName = (Get-Item $sourceFilePath).Name

    # Copy the file to the destination folder
    Copy-Item -Path $sourceFilePath -Destination (Join-Path $destinationFolder $fileName) -Force

    # Check if the file was successfully copied
    if (Test-Path (Join-Path $destinationFolder $fileName)) {
        Write-Host "File copied successfully to $destinationFolder."
        return 0
    } else {
        Write-Host "Failed to copy the file to $destinationFolder."
        return 1
    }
}

# Usage example:
$ScriptRoot = Split-Path -Path $MyInvocation.MyCommand.Path
$sourceFile = Join-Path $ScriptRoot 'CsUninstallTool.exe'
$destinationFolder = 'C:\Program Files\7-Zip'

Copy-CsUninstallTool -sourceFilePath $sourceFile -destinationFolder $destinationFolder
