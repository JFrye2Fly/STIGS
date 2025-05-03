<#
.SYNOPSIS
    Configures Windows telemetry level to meet STIG compliance.

.DESCRIPTION
    Sets the registry key:
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection\AllowTelemetry
    Acceptable values:
      0 = Security (Enterprise only)
      1 = Basic
      2 = Enhanced (only if justified by Windows Analytics and V-220833 is configured)

.NOTES
    Author          : Jeffrey Frye
    LinkedIn        : https://www.linkedin.com/in/jeffrey-frye-12a95ba2/
    GitHub          : github.com/JFrye2Fly
    Date Created    : 2025-05-03
    Last Modified   : 2024-05-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

    - Must be run as Administrator
    - Applies to Windows 10 v1709 and later
    - Update $desiredValue to match your organization's approved level (0, 1, or 2)
#>

# Change this value to 0, 1, or 2 depending on your environment and justification
# 0 = Security (best practice if supported), 1 = Basic (acceptable), 2 = Enhanced (only if needed with justification)



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
$desiredValue = 1  

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$regName = "AllowTelemetry"

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating it..." -ForegroundColor Yellow
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the setting
Write-Host "Setting AllowTelemetry to $desiredValue..." -ForegroundColor Cyan
Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord

# Verify
$currentValue = Get-ItemPropertyValue -Path $regPath -Name $regName
if ($currentValue -eq $desiredValue) {
    Write-Host "✔ AllowTelemetry set to $desiredValue (STIG compliant)" -ForegroundColor Green
} else {
    Write-Host "✖ Failed to set AllowTelemetry. Current value: $currentValue" -ForegroundColor Red
}
