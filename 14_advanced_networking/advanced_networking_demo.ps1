#!/usr/bin/env pwsh
# Advanced azure networking demo
# Peadar Grant

# resource group creation
az group create -n lab_rg -l westeurope

# vnet creation
az network vnet create -n lab_vnet -g lab_rg -l westeurope --address-prefix 10.0.0.0/16

# for the public subnet
az network vnet subnet create -n public_subnet -g lab_rg --vnet-name lab_vnet --address-prefix 10.0.1.0/24

# same for the private subnet
az network vnet subnet create -n private_subnet -g lab_rg --vnet-name lab_vnet --address-prefix 10.0.2.0/24


# Public VM

az network nsg create -g lab_rg -n public_vm_nsg

az network nsg rule create -g lab_rg --nsg-name public_vm_nsg --name AllowPublicSSH --protocol tcp --direction inbound --source-address-prefix '*' --destination-address-prefix '*' --destination-port-range 22 --access allow --priority 200

az network public-ip create -g lab_rg -n PublicVMIP

az network nic create -g lab_rg --name PublicNIC --vnet-name lab_vnet --subnet public_subnet --network-security-group public_vm_nsg --public-ip-address PublicVMIP

az vm create -g lab_rg -n public-vm --location westeurope --nics PublicNIC  --image 'Canonical:ubuntu-24_04-lts:server:latest' --admin-username developer --admin-password 1Password  --size Standard_B1s


# Private VM 1

az network nsg create -g lab_rg -n private_vm_nsg

az network nsg rule create -g lab_rg --nsg-name private_vm_nsg --name AllowSSHFromPublicSubnet --protocol tcp --direction inbound --source-address-prefix '10.0.1.0/24' --destination-address-prefix '*' --destination-port-range 22 --access allow --priority 200

az network nic create -g lab_rg --name PrivateNIC1 --vnet-name lab_vnet --subnet private_subnet --network-security-group private_vm_nsg

az vm create -g lab_rg -n private-vm-1 --location westeurope --nics PrivateNIC1  --image 'Canonical:ubuntu-24_04-lts:server:latest' --admin-username developer --admin-password 1Password  --size Standard_B1s
