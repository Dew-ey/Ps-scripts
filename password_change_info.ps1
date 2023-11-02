# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users and their last password set date
$users = Get-ADUser -Filter {Enabled -eq $true} -Properties PasswordLastSet

# Sort users by password last set date in descending order
$users = $users | Sort-Object -Property PasswordLastSet

#Stores Information into a text file
$outputFile = "password_change_date.txt"


foreach ($user in $users) {
    $userName = $user.SamAccountName
    $lastPasswordSet = $user.PasswordLastSet
    $output = "User: $userName - Last Password Change: $lastPasswordSet"
    # Writes output into the designated file
    Write-Host $output
    $output | Out-File -FilePath $outputFile -Append
}

Write-Host "Done"