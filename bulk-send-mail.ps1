

# Function to create report email
function SendNotification{
 $Msg = New-Object Net.Mail.MailMessage
 $Smtp = New-Object Net.Mail.SmtpClient($ExchangeServer)
 $Msg.From = $FromAddress
 $Msg.To.Add($ToAddress)
 $Msg.Subject = "New Remote Access"
 $Msg.Body = $EmailBody
 $Msg.IsBodyHTML = $true
 $Smtp.Send($Msg)
}
 
# Define local Exchange server info for message relay. Ensure that any servers running this script have permission to relay.
$ExchangeServer = "tenant-com.mail.protection.outlook.com". ##Add tenant
$FromAddress = "IT System Upgrades [No-Reply] <nr@domain.com>"
 
# Import user list and information from .CSV file
$Users = Import-Csv c:\Temp\email.csv
 
# Send notification to each user in the list
Foreach ($User in $Users) {
 $ToAddress = $User.Email
 
 $EmailBody = @"
 <p>Hello</p>
 
## HTML here  

<p>Thank you<br />Corporate Services | Systems IT </p>

"@

 Write-Host "Sending notification to $ToAddress" -ForegroundColor Yellow
 SendNotification
}
