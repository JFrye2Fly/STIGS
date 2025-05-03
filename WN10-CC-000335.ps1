<#
.SYNOPSIS
    Remediates STIG requirement by setting AllowUnencryptedTraffic to 0.

.DESCRIPTION
    Ensures the following registry setting:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client\AllowUnencryptedTraffic = 0

.NOTES
    - Must be run as Administrator
    - May require a WinRM or system restart to take full effect
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$regName = "AllowUnencryptedTraffic"
$desiredValue = 0

# Ensure registry path exists
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating..." -ForegroundColor Yellow
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Write-Host "Setting AllowUnencryptedTraffic to 0..." -ForegroundColor Cyan
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Verify and report
$currentValue = Get-ItemPropertyValue -Path $regPath -Name $regName
if ($currentValue -eq $desiredValue) {
    Write-Host "✔ Remediation complete: AllowUnencryptedTraffic = 0 (Unencrypted WinRM traffic disabled)" -ForegroundColor Green
} else {
    Write-Host "✖ Failed to set AllowUnencryptedTraffic. Current value: $currentValue" -ForegroundColor Red
}
