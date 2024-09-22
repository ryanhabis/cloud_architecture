#!/usr/bin/env pwsh
# Azure intro lab checks
# Peadar Grant

# Banner
Write-Host 'Azure lab intro checks'

# Check for resource group
Write-Host 'checking resource group...'
$rgs = (az group list --query "[?name=='lab_rg']" | ConvertFrom-Json)
if ( 1 -ne $rgs.length ) {
    $message = 'should be 1 resource group named lab_rg located in westeurope'
    Write-Host $message  -ForegroundColor Red
    Throw $message
}

# should be only 1 matching resource group, so [0]
$rg = $rgs[0]

# Check for linux VM
Write-Host 'checking lab-linux virtual machine...'
$vms = ( az vm list --query "[?name=='lab-linux']" | ConvertFrom-Json )
if ( 1 -ne $vms.length ) {
    $message = 'should be 1 VM named lab-linux' 
    Write-Host $message  -ForegroundColor Red
    Throw $message
}

# should be only 1 matching VM, so [0]
$vm = $vms[0]

Write-Host 'Lab checks passed' -ForegroundColor Green

