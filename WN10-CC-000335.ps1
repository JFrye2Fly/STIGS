<#
.SYNOPSIS
    Remediates STIG requirement by setting AllowUnencryptedTraffic to 0.

.DESCRIPTION
    Ensures the following registry setting:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client\AllowUnencryptedTraffic = 0

.NOTES
    Author          : Jeffrey Frye
    LinkedIn        : https://www.linkedin.com/in/jeffrey-frye-12a95ba2/
    GitHub          : github.com/JFrye2Fly
    Date Created    : 2025-05-03
    Last Modified   : 2024-05-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000335
    - Must be run as Administrator
    - May require a WinRM or system restart to take full effect

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
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
