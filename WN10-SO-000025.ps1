<#
.SYNOPSIS
    Renames the built-in Guest account to a non-default value per STIG compliance.

.DESCRIPTION
    This script checks for the existence of the default Guest account ("Guest") and renames it to a custom name
    (e.g., "DisabledGuest"). Modify `$newName` as needed to match your organization's policy.

.NOTES
    Author          : Jeffrey Frye
    LinkedIn        : linkedin.com/in/jeffrey-frye-12a95ba2/
    GitHub          : github.com/JFrye2Fly
    Date Created    : 2025-05-03
    Last Modified   : 2025-05-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000025

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000025).ps1 
#>

# Set desired new name for Guest account
$newName = "DisabledGuest"

# Get the SID of the built-in Guest account (well-known SID: S-1-5-21domain-501)
$guestAccount = Get-WmiObject Win32_UserAccount -Filter "LocalAccount=True AND SID LIKE '%-501' AND Disabled=FALSE"

if ($guestAccount) {
    if ($guestAccount.Name -eq $newName) {
        Write-Host "✔ Guest account is already renamed to '$newName'." -ForegroundColor Green
    } else {
        Write-Host "Renaming Guest account from '$($guestAccount.Name)' to '$newName'..." -ForegroundColor Cyan
        try {
            Rename-LocalUser -Name $guestAccount.Name -NewName $newName
            Write-Host "✔ Guest account successfully renamed to '$newName'." -ForegroundColor Green
        } catch {
            Write-Host "✖ Failed to rename Guest account: $_" -ForegroundColor Red
        }
    }
} else {
    Write-Host "✔ Guest account is already disabled or renamed." -ForegroundColor Green
}
