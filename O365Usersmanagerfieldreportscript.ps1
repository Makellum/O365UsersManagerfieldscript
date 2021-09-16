connectto-365

$Result = @()
$AllUsers= Get-AzureADUser -All $true | Select-Object -Property Displayname,UserPrincipalName
$TotalUsers = $AllUsers.Count
$i = 1 
$AllUsers | ForEach-Object {
$User = $_
Write-Progress -Activity "Processing $($_.Displayname)" -Status "$i out of $TotalUsers completed"
$managerObj = Get-AzureADUserManager -ObjectId $User.UserPrincipalName
$Result += New-Object PSObject -property @{ 
UserName = $User.DisplayName
UserPrincipalName = $User.UserPrincipalName
ManagerName = if ($managerObj -ne $null) { $managerObj.DisplayName } else { $null }
ManagerMail = if ($managerObj -ne $null) { $managerObj.Mail } else { $null }
}
$i++
}

 

$Result | Select UserName, UserPrincipalName, ManagerName,ManagerMail  |

Export-CSV "C:\Users\AmberKellum\Downloads\O365UsersManagerInfo.CSV" -NoTypeInformation -Encoding UTF8