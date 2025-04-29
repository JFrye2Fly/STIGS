<#
.SYNOPSIS
    This PowerShell script ensures that Inactivity Timer is set to 15 minutes max.

.NOTES
    Author          : Jeffrey Frye
    LinkedIn        : https://www.linkedin.com/in/jeffrey-frye-12a95ba2/
    GitHub          : github.com/JFrye2Fly
    Date Created    : 2025-04-29
    Last Modified   : 2024-04-29
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


# Set the value to 900 seconds (if needed)
Set-ItemProperty -Path $registryPath -Name $valueName -Value 900 -Type DWord
Write-Output "Set InactivityTimeoutSecs to 900 seconds."



# The code below can be run to check if the InactivityTimeoutSecs attribute is set or not:

---------------------------------------------------------------------------------------------

# # Define registry path and value
# $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
# $valueName = "InactivityTimeoutSecs"

# # Check if the registry value exists
# if (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue) {
#     $value = (Get-ItemProperty -Path $registryPath -Name $valueName).$valueName

#     if ($value -eq 0) {
#         Write-Output "Finding: InactivityTimeoutSecs is set to 0 (disabled)."
#     } elseif ($value -gt 900) {
#         Write-Output "Finding: InactivityTimeoutSecs is set to $value, which is greater than 900."
#     } else {
#         Write-Output "Compliant: InactivityTimeoutSecs is set to $value."
#     }
# } else {
#     Write-Output "Finding: InactivityTimeoutSecs does not exist."
# }

# # To set the value to 900 seconds (if needed)
# # Set-ItemProperty -Path $registryPath -Name $valueName -Value 900 -Type DWord
# # Write-Output "Set InactivityTimeoutSecs to 900 seconds."

