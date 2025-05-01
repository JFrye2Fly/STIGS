<#
.SYNOPSIS
    This powershell script ensures that the  Windows dialog box title for the legal banner is configured. 

.NOTES
    Author          : Jeffrey Frye
    LinkedIn        : linkedin.com/in/jeffrey-frye-12a95ba2/
    GitHub          : github.com/JFrye2Fly
    Date Created    : 2025-04-30
    Last Modified   : 2025-04-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000080

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(WN10-SO-000080).ps1 
#>

# Define the desired registry path and value
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "LegalNoticeCaption"
$desiredValue = "DoD Notice and Consent Banner"

# Check if the registry key exists
if (-not (Test-Path $regPath)) {
    Write-Output "Registry path does not exist. Creating it..."
    New-Item -Path $regPath -Force | Out-Null
}

# Check if the value exists and is correct
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName -ErrorAction SilentlyContinue

if ($currentValue -ne $desiredValue) {
    Write-Output "Setting $valueName to '$desiredValue'..."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type String
} else {
    Write-Output "$valueName is already set correctly."
}
s
