Import-Module 'C:\Program Files\Microsoft Dynamics NAV\100\Service\NavAdminTool.ps1' -WarningAction SilentlyContinue -Scope Global -Force| out-null
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.NAV.Model.Tools.psd1' -WarningAction SilentlyContinue -Scope Global -Force | out-null
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.Nav.Apps.Tools.psd1' -WarningAction SilentlyContinue -Scope Global -Force | out-null

#Vars
$DEVInstanceName = 'Rental_DEV'

#create DEV Instance
get-navserverinstance | Copy-NAVEnvironment -ToServerInstance $DEVInstanceName

#Enable 
#Get-NAVServerInstanceDetails $DEVInstanceName
Set-NAVServerConfiguration -ServerInstance $DEVInstanceName -KeyName 'DeveloperServicesEnabled' -KeyValue 'True'
Set-NAVServerInstance -ServerInstance $DEVInstanceName -Restart 

Get-NAVServerInstance