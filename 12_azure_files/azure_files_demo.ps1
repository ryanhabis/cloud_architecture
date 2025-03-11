#!/usr/bin/env pwsh
# Azure files demo
# Peadar Grant

# Check for Azure login
if ( -not ((az account show | ConvertFrom-Json).user.name) ) {
    throw "Not logged into Azure on the CLI"
}

# Create resource group
az group create -n lab_rg -l westeurope

