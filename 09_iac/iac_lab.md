% IAC lab

# Task 0: Login to Azure

Login to the [Azure Portal](https://portal.azure.com/)

Check that you can run the `az` command by running an operation requiring authentication, for example:

	az account show
	
	
# Task 1: Resource group creation

Create the `lab_rg` resource group for today's work: 

	az group create -n lab_rg -l westeurope
	
	
# Task 2: VNet and Subnet Creation

We are going to create a VNet and 1 Subnet explicitly to hold our two VMs.

	az network vnet create -n lab-vnet --resource-group lab_rg --address-prefix 10.0.0.0/16 --subnet-name lab-subnet-1 --subnet-prefixes 10.0.0.0/24
	

# Task 3: Linux VM creation

## Basics page

Use defaults except

- in your `lab_rg` group
- named `linux-vm`
- No infrastructure redundancy
- Ubuntu Linux
- size B1s
- SSH login using `developer` as user name

## Networking page

Here we'll explicitly set the new VM to our VNet and Subnet:

- Virtual network: lab-vnet
- Subnet: lab-subnet-1

## Advanced page

In *Custom data* paste in the contents of `vm_config.yml` .


## Review and create 

You can go ahead and create the VM.


# Task 4: Create Windows VM

## Basics page

Use defaults except

- in your `lab_rg` group
- named `windows-vm`
- No infrastructure redundancy
- Windows Server 2022 Datacenter: Azure Edition - x64 Gen2
- size B2s
- Administrator account using `developer` as user name
- Add SSH to the list of allowed inbound ports. Should be both RDP and SSH.

## Networking page

- Virtual network: lab-vnet
- Subnet: lab-subnet-1

## Advanced page

Under extensions search for and add OpenSSH.


# Task 5: Confirm connectivity

Confirm that you can login over SSH to the linux server.

Confirm that the cloud-init script has run.

Confirm that you can login over SSH to the Windows server.

Finally confirm that you can login over RDP to the Windows VM.


# Task 6: Template

Navigate to your `lab_rg` resource group, go to *Automation* and then *Export template*.

Leave the Include Parameters switch on, and download the template.
There will be **2 files**.


# Task 7: Delete your resource group

Delete your resource group and its contents
	
	az group delete -n lab_rg
	
	
# Task 8: Template modification

You will have to modify the template in 3 places.

## Admin password

After the `adminUsername` property add in the `adminPassword` property with your chosen admin password:

	"adminPassword": "1Password2024.",
	
## Disk provisioning

Replace: 

	"managedDisk": {
		"storageAccountType": "Premium_LRS",
		"id": "[parameters('virtualMachines_HCM200_id')]"
	},

with this:

	"managedDisk": {
		"storageAccountType": "Standard_LRS"
	},
	
## Guest provision signal

Remove the following property:

	"requireGuestProvisionSignal": true
	

# Task 9: Import template

Create a resource group to hold the template(s)

	az group create -n lab_templates -l westeurope
	
In the portal search for *Template specs*, and hit *Import Template*.
Choose your template file from the dropdown.
Call it `lab_setup`. 
Set version to 1.


# Task 10: Deploy template

Hit the deploy button and your template *should* work.

