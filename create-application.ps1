# Sign in to Azure.
Login-AzureRmAccount
# If your Azure account is on a non-public cloud, make sure to specify the proper environment 
# example for the German cloud:
# Login-AzureRmAccount -EnvironmentName AzureGermanCloud

# If you have multiple subscriptions, uncomment and set to the subscription you want to work with:
# $subscriptionId = "11111111-aaaa-bbbb-cccc-222222222222"
# Set-AzureRmContext -SubscriptionId $subscriptionId

# Provide these values for your new Azure AD app:
# $appName is the display name for your app, must be unique in your directory
# $uri does not need to be a real URI
# $secret is a password you create
$appName = "yourappname"
$uri = "http://yourappname"
$secret = "yoursecret"

# Create the Azure AD app
$azureAdApplication = New-AzureRmADApplication -DisplayName $appName -HomePage $Uri -IdentifierUris $Uri -Password $secret

# Create a Service Principal for the app
$svcprincipal = New-AzureRmADServicePrincipal -ApplicationId $azureAdApplication.ApplicationId

# Assign the Contributor RBAC role to the service principal
# If you get a PrincipalNotFound error: wait 15 seconds, then rerun the following until successful
$roleassignment = New-AzureRmRoleAssignment -RoleDefinitionName Contributor -ServicePrincipalName $azureAdApplication.ApplicationId.Guid

# Display the values for your application 
Write-Output "Save these values for using them in your application"
Write-Output "Subscription ID:" (Get-AzureRmContext).Subscription.SubscriptionId
Write-Output "Tenant ID:" (Get-AzureRmContext).Tenant.TenantId
Write-Output "Application ID:" $azureAdApplication.ApplicationId.Guid
Write-Output "Application Secret:" $secret