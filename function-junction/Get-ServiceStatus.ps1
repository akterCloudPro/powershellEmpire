function Get-ServiceStatus {
    param (
        [string]$serviceName
    )

    try {
        $service = Get-Service -Name $serviceName -ErrorAction Stop
        return $service.Status -eq "Running"
    }
    catch {
        return $false
    }
}

## Example Usage
$serviceName = "DbxSvc"
$status = Get-ServiceStatus -serviceName $serviceName
Write-Host $status
