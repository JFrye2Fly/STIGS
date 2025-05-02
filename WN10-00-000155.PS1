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

# Disable PowerShell v2 features if they are enabled
$features = @("MicrosoftWindowsPowerShellV2", "MicrosoftWindowsPowerShellV2Root")

foreach ($feature in $features) {
    $status = Get-WindowsOptionalFeature -Online -FeatureName $feature
    if ($status.State -eq "Enabled") {
        Write-Output "Disabling feature: $feature"
        Disable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
    } else {
        Write-Output "$feature is already disabled."
    }
}

Write-Output "Remediation complete. A restart may be required for changes to take effect."
