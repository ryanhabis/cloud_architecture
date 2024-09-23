#!/usr/bin/env pwsh
# Azure Account clear
# Peadar Grant

# clear existing azure account info
az account clear

# disable the broker service
az config set core.enable_broker_on_windows=false

# now try the azure login again
az login

