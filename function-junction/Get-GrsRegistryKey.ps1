## Function to find GRS ID from Intune Management Extension logs
## What is GRS?  if the app fails to install in all the 3 attempts, GRS (Global Reevaluation Scheme) kicks in 
## which makes IME to ignore the app for further retries, for the next 24 hours since the last failed attempt.

    function Get-GrsRegistryKey {
        param (
            [string]$appId
        )

        $intuneLogList = Get-ChildItem -Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs" -Filter "IntuneManagementExtension*.log" -File | Sort-Object LastWriteTime -Descending | Select-Object -ExpandProperty FullName

        if (!$intuneLogList) {
            Write-Error "Unable to find any Intune log files. Redeploy will probably not work as expected."
            return
        }

        foreach ($intuneLog in $intuneLogList) {
            $appMatch = Select-String -Path $intuneLog -Pattern "\[Win32App\]\[GRSManager\] App with id: $appId is not expired." -Context 0, 1

            if ($appMatch) {
                foreach ($match in $appMatch) {
                    $Hash = ""
                    $LineNumber = $match.LineNumber
                    $Hash = Get-Content $intuneLog | Select-Object -Skip $LineNumber -First 1

                    if ($hash) {
                        $hash = $hash.Replace('+', '\+')
                        return $hash = ($Hash -split '=')[1].Trim()

                    }
                }
            }
        }
    }

    
    ## Example Usage
    $appID = '010a1e71-f77d-4cc2-b7ec-8d655b6f98a0'
    $grsID = Get-GrsRegistryKey -appId $appID

    ## Remove Grs keys from registry with Get-GrsRegistryKey function
    $targetGrsID = $grsID + '='
    $grsRegistryPaths = 'HKLM:\SOFTWARE\Microsoft\IntuneManagementExtension\Win32Apps\*\GRS\*'
    foreach ($grsRegistryPath in $grsRegistryPaths) {
        Get-ChildItem -Path $grsRegistryPath | Remove-Item -Include $targetGrsID
    }
