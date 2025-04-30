<#
.SYNOPSIS
    This PowerShell script configures the system to always require users to type in a username and password to elevate a running application so that unauthorized users cannot elevate without proper authentication. 

.NOTES
    Author          : Jeffrey Frye
    LinkedIn        : https://www.linkedin.com/in/jeffrey-frye-12a95ba2/
    GitHub          : github.com/JFrye2Fly
    Date Created    : 2025-04-30
    Last Modified   : 2024-04-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000070 

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

$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\CredUI"
$valueName = "EnumerateAdministrators"
$desiredValue = 0

# Check current value
$currentValue = (Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue).$valueName

if ($currentValue -ne $desiredValue) {
    Write-Output "Non-compliant: EnumerateAdministrators is not set to 0. Remediating..."
    
    # Ensure the registry key exists
    if (-not (Test-Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    # Set the correct value
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord

    Write-Output "EnumerateAdministrators has been set to 0."
} else {
    Write-Output "Compliant: EnumerateAdministrators is already set to 0. No action needed."
}


---------------------------------------------------------------------------------------------


