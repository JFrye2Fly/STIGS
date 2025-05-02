<#
.SYNOPSIS
    This PowerShell script ensures that Windows Remote Management (WinRM) service cannot send passwords in plain text.

.NOTES
    Author          : Jeffrey Frye
    LinkedIn        : https://www.linkedin.com/in/jeffrey-frye-12a95ba2/
    GitHub          : github.com/JFrye2Fly
    Date Created    : 2025-05-02
    Last Modified   : 2024-05-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000345

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

# Define registry path and expected value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service"
$valueName = "AllowBasic"
$expectedValue = 0

# Check if the registry path exists
if (!(Test-Path $regPath)) {
    Write-Output "Registry path does not exist. Creating path: $regPath"
    New-Item -Path $regPath -Force | Out-Null
}

# Check if the value exists and is set correctly
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    Write-Output "'$valueName' does not exist. Setting it to $expectedValue."
    New-ItemProperty -Path $regPath -Name $valueName -Value $expectedValue -PropertyType DWORD -Force | Out-Null
}
elseif ($currentValue.$valueName -ne $expectedValue) {
    Write-Output "'$valueName' is set to $($currentValue.$valueName). Changing it to $expectedValue."
    Set-ItemProperty -Path $regPath -Name $valueName -Value $expectedValue
}
else {
    Write-Output "'$valueName' is already set to the correct value: $expectedValue"
}

# Optional: Confirm final value
$final = Get-ItemProperty -Path $regPath -Name $valueName
Write-Output "Final value of '$valueName': $($final.$valueName)"
