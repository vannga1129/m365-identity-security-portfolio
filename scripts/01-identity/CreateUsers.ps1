# If you are already connected to your Tenant from the 01-01-ConnectMgGraph.ps1 script, 
# you can skip the connection part in this script.
$TenantID = "please-insert-your-TenantID-here" # <-- Remember to change this to your TenantID
Connect-MgGraph -TenantId $TenantID -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All", "RoleManagement.ReadWrite.Directory"

# Create users
Get-Help New-MgUser -Online


$users = Import-CSV -Path 'Users-sample.csv' -Delimiter ","

$PasswordProfile = @{
    Password = 'xxxxxxxxxxxxxxxx' # <-- Remember to insert this to your password
    }
    
foreach ($user in $users) {
    $Params = @{
        UserPrincipalName = $user.givenName + "." + $user.surName + "@cire319.onmicrosoft.com"
        DisplayName = $user.givenName + " " + $user.surname
        GivenName = $user.GivenName
        Surname = $user.Surname
        MailNickname = $user.givenName + "." + $user.surname
        AccountEnabled = $true
        PasswordProfile = $PasswordProfile
        Department = $user.Department
        CompanyName = $user.CompanyName
        Country = $user.Country
        City = $user.City
        JobTitle = $user.JobTitle
    }
    $Params
    New-MgUser @Params
}


