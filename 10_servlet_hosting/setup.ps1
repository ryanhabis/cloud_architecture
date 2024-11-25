# Setup file for web app install (Starting point for CA1)
# Peadar Grant-FileShareAccess

# Create resource group
az group create -n lab_rg -l westeurope

# Create VM
az vm create -n web-vm --resource-group lab_rg --size Standard_B2s --image 'Canonical:ubuntu-24_04-lts:server:latest' --admin-user developer --admin-password 1Password2024. --custom-data vm_config.yml

# Open port for Tomcat
az vm open-port -g lab_rg -n web-vm --port 8080

