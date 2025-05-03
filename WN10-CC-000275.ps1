<#
.SYNOPSIS
   Remediates STIG ID: WN10-CC-000275 by disabling client drive mapping in RDP sessions.

   .DESCRIPTION
    Sets the registry key:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\fDisableCdm = 1

   .NOTES
    Author          : Jeffrey Frye
    LinkedIn        : https://www.linkedin.com/in/jeffrey-frye-12a95ba2/
    GitHub          : github.com/JFrye2Fly
    Date Created    : 2025-05-03
    Last Modified   : 2024-05-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000275
    - STIG ID: WN10-CC-000275
    - SRG: SRG-OS-000138-GPOS-00069
    - Severity: Medium
    - Must be run as Administrator
    - May require a reboot or Group Policy refresh to apply

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000275).ps1 
#>


$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$regName = "fDisableCdm"
$desiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating path..." -ForegroundColor Yellow
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Write-Host "Setting fDisableCdm to 1..." -ForegroundColor Cyan
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Confirm and report result
$currentValue = Get-ItemPropertyValue -Path $regPath -Name $regName
if ($currentValue -eq $desiredValue) {
    Write-Host "✔ Remediation complete: fDisableCdm = 1 (Drive redirection disabled)" -ForegroundColor Green
} else {
    Write-Host "✖ Failed to set fDisableCdm. Current value: $currentValue" -ForegroundColor Red
}


#---------------------------------------------------------------------------------------------

