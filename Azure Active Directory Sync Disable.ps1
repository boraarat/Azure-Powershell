Azure Active Directory Kullanıcı Sync Kapatma


Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking


Install-Module -Name AzureAD

Get-MailUser

Set-MsolDirSyncEnabled -EnableDirSync $false

Connect-MsolService