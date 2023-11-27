function CheckFilesExistence {
    param (
        [string[]]$files
    )

    foreach ($file in $files) {
        if (-not (Test-Path $file)) {
            return $false
            
        }
    }

    return $true
}

# Example usage:
$file1 = "C:\Checker\test1.txt"
$file2 = "C:\Checker\test2.txt"
$file3 = "C:\Checker\test3.txt"

$filesToCheck = @($file1, $file2, $file3)
$result = CheckFilesExistence -files $filesToCheck
if ($result) {
    Write-Host "All files exist."
} else {
    Write-Host "One or more files are missing."
}
