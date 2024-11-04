#!/usr/bin/env pwsh
# Queue processor
# Peadar Grant

Param (
[Parameter(Mandatory=$true)] $StorageAccountName
)

$QueueName='coffeeq'

while(1) {
	
	$message = ( az storage message get --account-name $StorageAccountName --queue-name $QueueName --auth-mode key --only-show-errors)

	if ( $message -eq "[]" ) {
		Write-Host "no message" -ForegroundColor DarkBlue
	} else {
		$message = $message | ConvertFrom-Json
		Write-Host $message.content -ForegroundColor green
		$result = az storage message delete --account-name $StorageAccountName --queue-name $QueueName --auth-mode key  --id $message.id  --pop-receipt $message.popReceipt --only-show-errors
	}

	Start-Sleep -Seconds 5

}