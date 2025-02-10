#!/usr/bin/env pwsh
# Networking Lab Demo
# Peadar Grant

# Based on guide at:
# https://learn.microsoft.com/en-us/azure/virtual-network/quick-create-powershell

$rgName = 'lab_rg'
$location = 'westeurope'

# create the resource group
$rg = @{
    Name = $rgName
    Location = $location
}
New-AzResourceGroup @rg

# create the vnet
$vnet = @{
    Name = 'lab-vnet'
    ResourceGroupName = $rgName
    Location = $location
    AddressPrefix = '10.0.0.0/16'
}
$virtualNetwork = New-AzVirtualNetwork @vnet

# create the subnet configuration
$subnet = @{
    Name = 'lab-subnet'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '10.0.0.0/24'
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet

# Associate the subnet configuration to the virtual network
$virtualNetwork | Set-AzVirtualNetwork

