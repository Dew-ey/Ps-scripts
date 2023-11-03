# Imports AD module

Import-Module ActiveDirectory

# Gets all disabled users 

$disUsers = Get-ADUser -Filter {Enabled -eq $false}

# Sorts Given useres via last logon date

$disUsers = $disUsers | Sort-Object -Property LastLogon -Descending

# Displayls list of disabled users and last logon time

foreach ($user in $disUsers){
    $userName = $user.SamAccountName
    $lastLogon = [DateTime]::FromFileTime($user.LastLogon)
    Write-Host "Disabled User: $userName - Last Logon: $lastLogon"
}