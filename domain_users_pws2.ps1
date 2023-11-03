# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users this time in the domain users group and all subgroups inside of it
$usersInDomainGroup = Get-ADGroupMember -Identity "Domain Users" | Where-Object {$_.objectClass -eq "user"}

# Get password last set date for users in the Domain Users group by placing objects in an array and parsing
$users = @()
foreach ($user in $usersInDomainGroup) {
    $userInfo = Get-ADUser -Identity $user -Properties Enabled, PasswordLastSet
    if ($userInfo.Enabled -eq $true){
        $users += $userInfo
    }
}

# Sort users by password last set date in descending order
$users = $users | Sort-Object -Property PasswordLastSet -Descending

#Stores Information into a text file
$outputFile = "domain_users_pwlastchange.txt"


foreach ($user in $users) {
    $userName = $user.SamAccountName
    $lastPasswordSet = $user.PasswordLastSet
    $output = "User: $userName - Last Password Change: $lastPasswordSet"
    # Writes output into the designated file
    Write-Host $output
    $output | Out-File -FilePath $outputFile -Append
}

Write-Host "Done and saved to $outputFile"