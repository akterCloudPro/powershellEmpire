## Function :: Remove targeted registry key items
function RemoveRegistryKey {
    param (
        [string]$appId,
        [string]$registryPath
    )

    Get-ChildItem $registryPath -Rec -EA SilentlyContinue | ForEach-Object {
        $CurrentKey = (Get-ItemProperty -Path $_.PsPath)
        If ($CurrentKey -match $appId){
          $CurrentKey|Remove-Item -Recurse -Force
        }
     }
}

## Example Usage ##
$appId = '010a1e71-f77d-4cc2-b7ec-8d655b6f98a0' ## Deployed appId from Intune portal 
$registryPath = 'HKLM:SOFTWARE\Microsoft\IntuneManagementExtension\Win32Apps\*\'
RemoveRegistryKey -appId $appId -registryPath $registryPath
