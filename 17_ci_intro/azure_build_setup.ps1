#!/usr/bin/env pwsh
# Azure build environment setup
# Peadar Grant

$loc = 'westeurope'
$rg = 'lab_rg'
$vnet = 'lab_vnet'
$subnet = 'lab_subnet'
$nsg = 'lab_nsg'

# resource group setup
Write-Host 'creating resource group' -ForegroundColor Green
az group create -n $rg -l $loc

# create the vnet
Write-Host 'creating vnet' -ForegroundColor Green
az network vnet create -n $vnet -g $rg -l $loc --address-prefix 10.0.0.0/16

# create the subnet (in lab_vnet)
Write-Host 'creating subnet' -ForegroundColor Green
az network vnet subnet create -n $subnet -g $rg --vnet-name $vnet --address-prefix 10.0.1.0/24

# create the network security group
Write-Host 'creating network security group' -ForegroundColor Green
az network nsg create -g $rg -n $nsg

# create the build VM public IP address
Write-Host 'creating public IP' -ForegroundColor Green
az network public-ip create -g $rg -n build_vm_public_ip

# create the NIC
Write-Host 'creating NIC' -ForegroundColor Green
az network nic create -g $rg --name build_vm_nic --vnet-name $vnet --subnet $subnet --network-security-group $nsg --public-ip-address build_vm_public_ip

# create the VM
Write-Host 'creating VM' -ForegroundColor Green
az vm create -g $rg -n build-vm --location $loc --nics build_vm_nic  --image 'Canonical:ubuntu-24_04-lts:server:latest' --admin-username developer --admin-password 1Password2025.  --size Standard_B1s  --custom-data build_vm_config.yml

# add the SSH inbound rule to the NSG
Write-Host 'adding inbound SSH rule' -ForegroundColor Green
az network nsg rule create -g $rg --nsg-name $nsg --name AllowSSHFromInternet --protocol tcp --direction inbound --source-address-prefix '*' --destination-address-prefix '*' --destination-port-range 22 --access allow --priority 200

