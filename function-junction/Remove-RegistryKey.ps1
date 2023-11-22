function Remove-RegistryKey {
    param (
        [string]$appId,
        [string]$appVersion,
        [string]$regChildPath
    )

    $targetAppID = "${appId}_${appVersion}"
    [string[]]$registryHives = @("HKLM:")

    foreach ($hive in $registryHives) {
        $registryPath = Join-Path -Path $hive -ChildPath ${regChildPath}${targetAppID}

        if (Test-Path -Path $registryPath) {
            Remove-Item -Path $registryPath -Recurse -Force
            Write-Host "Registry key '$registryPath' deleted successfully."
        } else {
            Write-Host "Registry key '$registryPath' not found."
        }
    }
}

## Initialize the variables with the necessary values.
$appID = '010a1e71-f77d-4cc2-b7ec-8d655b6f98a0'
$appVersion = '1'
$regChildPath = 'SOFTWARE\Microsoft\IntuneManagementExtension\Win32Apps\*\'


## Usage example:
Remove-RegistryKey -appId $appID -appVersion $appVersion -regChildPath $regChildPath
