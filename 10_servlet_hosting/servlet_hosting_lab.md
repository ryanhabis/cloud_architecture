% Servlet hosting lab

# Links

	https://www.digitalocean.com/community/tutorials/install-tomcat-on-linux

# Info commands

Images (to start from)

	az vm image list --output table

Sizes

	az vm list-sizes
	
	
# VM creation

Create ubuntu B1s VM 

	az vm create --resource-group lab_rg -n web-vm --image Ubuntu2204 --custom-data vm_config.yml --admin-user developer --admin-password 1Password2024.
	
	