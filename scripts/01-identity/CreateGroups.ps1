# If you are already connected to your Tenant from the 01-01-ConnectMgGraph.ps1 script, 
# you can skip the connection part in this script.
$TenantID = "please-insert-your-TenantID-here" # <-- Remember to change this to your TenantID
Connect-MgGraph -TenantId $TenantID -Scopes "User.ReadWrite.All", "Group.ReadWrite.All", "Directory.ReadWrite.All", "RoleManagement.ReadWrite.Directory"



# Create groups
Get-Help New-MgGroup -Online

# Step 1: Create department-specific dynamic M365 groups
$departments = @("Nytech-Management", "DEP-Utvikling", "DEP-SalgMarkedsforing", "DEP-Kundesupport", "SEC-IT-ADMIN", "DEP-Administrasjon")
foreach ($department in $departments) {
    $membershiprule = "user.department -eq `"$department`""
    $Params = @{
        DisplayName = "$department"
        Description = "Gruppe for ansatte i avdelingen $department"
        MailEnabled = $true
        MailNickname = $department
        SecurityEnabled = $true
        GroupTypes = @("Unified", "DynamicMembership")
        MembershipRule = $membershiprule
        MembershipRuleProcessingState = "On"
    }
    New-MgGroup @Params
}

# Step 2: Create cross-functional collaboration groups with corrected dynamic membership rules
$crossFunctionalGroups = @(
    @{
        DisplayName = "O365-TEAM-ProdSalg"
        Description = "Gruppe dedikert til samarbeid mellom produktutvikling og salg."
        MembershipRule = "(user.department -eq `"DEP-Utvikling`") -or (user.department -eq `"DEP-SalgMarkedsforing`")"
    },
    @{
        DisplayName = "O365-TEAM-SupportDev"
        Description = "Gruppe for kommunikasjon og tilbakemelding mellom support og utviklere for å forbedre produkter."
        MembershipRule = "(user.department -eq `"DEP-Kundesupport'`") -or (user.department -eq `"DEP-Utvikling`")"
    },
    @{
        DisplayName = "O365-TEAM-SalgSupport"
        Description = "Gruppe for å styrke samarbeid rundt kundeoppfølging og salgssupport."
        MembershipRule = "(user.department -eq `"DEP-SalgMarkedsforing`") -or (user.department -eq `"DEP-Kundesupport`")"
    }
)

foreach ($group in $crossFunctionalGroups) {
    $Params = @{
        DisplayName = $group.DisplayName
        Description = $group.Description
        MailEnabled = $false
        MailNickname = $group.DisplayName -replace ' ', ''
        SecurityEnabled = $true
        GroupTypes = @("Unified", "DynamicMembership")
        MembershipRule = $group.MembershipRule
        MembershipRuleProcessingState = "On"
    }
    New-MgGroup @Params
}

# Step 3: Create an additional group for license assignment
$Params = @{
    DisplayName = "m365-license"
    Description = "Members of this group will get a M365 license"
    MailEnabled = $false
    MailNickname = "m365-license"
    SecurityEnabled = $true
    GroupTypes = @("Unified", "DynamicMembership")  # Make it a dynamic group
    MembershipRule = "(user.accountEnabled -eq $true)"  # Rule to include all active users
    MembershipRuleProcessingState = "On"
}
New-MgGroup @Params


