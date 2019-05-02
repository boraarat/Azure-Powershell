Import-Module MSOnline
$LiveCred = Get-Credential
$s = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $cred -Authentication Basic –AllowRedirection

  
Connect-MsolService –Credential $LiveCred
Get-MsolUser 
Get-Mailbox
Get-AuthServer | Format-List *
Get-ManagementRole 

Get-DkimSigningConfig


get-mailbox | Set-MailboxRegionalConfiguration   -Language 1055 -DateFormat d.MM.yyyy -TimeZone "Turkey Standard Time"

get-mailbox | Set-MailboxRegionalConfiguration  -Language 1055 -TimeZone "Turkey Standard Time"

Get-MailboxRegionalConfiguration -Identity "marketing"

get-mailbox 






Install-Module AzureRM -force
Install-Module Azure -force
Import-Module AzureRm 
Import-Module Azure
Login-AzureRmAccount
Add-AzureAccount  
 

Get-AzureRmSubscription
 
#Yeni Taşınacak Azure Subs ID  Exp. CSP
Select-AzureRmSubscription -SubscriptionId 43504e3b-a698-462c-b1de-134f3be9387e

#Taşıması yapılacak Eski Azure Subs ID Exp. Bizpark
Get-AzureSubscription 
Select-AzureSubscription -SubscriptionId a5c4e881-57c4-4240-9494-483ff28288c9
 
Register-AzureRmResourceProvider -ProviderNamespace Microsoft.ClassicInfrastructureMigrate
 
 
Get-AzureRmResourceProvider -ProviderNamespace Microsoft.ClassicInfrastructureMigrate 
 
 
 #Provide the subscription Id of the subscription where managed disk exists  Example:Bizpark
$sourceSubscriptionId='a5c4e881-57c4-4240-9494-483ff28288c9'
 
#Provide the name of your resource group where managed disk exists  Example:Bizpark
$sourceResourceGroupName='TEMP'
 
#Provide the name of the managed disk  Disk Adı Example:Bizpark
$managedDiskName='temp-workspace_OsDisk_1_b6d8581cf28a4aff970b60af38a6b113'
 
#Set the context to the subscription Id where Managed Disk exists
Select-AzureRmSubscription -SubscriptionId $sourceSubscriptionId
 
#Get the source managed disk
$managedDisk= Get-AzureRMDisk -ResourceGroupName $sourceResourceGroupName -DiskName $managedDiskName
 
#Provide the subscription Id of the subscription where managed disk will be copied to
#If managed disk is copied to the same subscription then you can skip this step   
$targetSubscriptionId='43504e3b-a698-462c-b1de-134f3be9387e'
 
#Name of the resource group where snapshot will be copied to
$targetResourceGroupName='TEMP'
 
#Set the context to the subscription Id where managed disk will be copied to
#If snapshot is copied to the same subscription then you can skip this step
Select-AzureRmSubscription -SubscriptionId $targetSubscriptionId
 
$diskConfig = New-AzureRmDiskConfig -SourceResourceId $managedDisk.Id -Location $managedDisk.Location -CreateOption Copy 
 
#Create a new managed disk in the target subscription and resource group
New-AzureRmDisk -Disk $diskConfig -DiskName $managedDiskName -ResourceGroupName $targetResourceGroupName 
