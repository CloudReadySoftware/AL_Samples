Import-Module 'C:\Program Files\Microsoft Dynamics NAV\100\Service\NavAdminTool.ps1' -WarningAction SilentlyContinue -Scope Global -Force| out-null
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.NAV.Model.Tools.psd1' -WarningAction SilentlyContinue -Scope Global -Force | out-null
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.Nav.Apps.Tools.psd1' -WarningAction SilentlyContinue -Scope Global -Force | out-null

#Vars
$DEVInstanceName = 'NAV'
$AppName = 'Rental'

Get-NAVAppInfo -ServerInstance $DEVInstanceName | where Name -like "*$AppName*" | Uninstall-NAVApp -Tenant default
Get-NAVAppInfo -ServerInstance $DEVInstanceName | where Name -like "*$AppName*" | Unpublish-NAVApp
