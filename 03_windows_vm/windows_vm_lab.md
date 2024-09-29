% Windows VM lab

# Task 1: Setup

Login to [the Azure portal](https://portal.azure.com/#home) via the Web browser.
Use your DkIT credentials, which will require MFA.

Ensure that the Azure CLI works correctly by running the command:

	az account show
	
If this succeeds (by showing you your Azure account information) then you can move on to the next task. 
If this command fails, login to Azure using:

	az login
	
Try the `az account show` command before moving on.


# Task 2: Creating a resource group

Last time we created an Azure resource group using the portal.
Today we'll create an Azuzre resource group using the CLI.

## Showing existing resource groups

First let's list out the existing resource groups using the command:

	az group list
	
There may be no groups, or just one called `NetworkWaterRG` which you can ignore.
It's internally used by some Azure features.


## Creating the new group

We'll follow a pattern of using `lab_rg` as our resource group for lab work.
This makes it easy to delete the resource group and all of its contents when finished.

Create the new group called `lab_rg` in the `westeurope` (Ireland) region using the command

	az group create --name lab_rg --location westeurope
	
It will return some information about the new group in JSON format (like most of the other commands).
Confirm that your new group exists by listing out the groups in your account:

	az group list
	

*Notice that this is much shorter than the GUI-driven process from last week!*



# Task 3: Create a Windows VM

This lab we'll instead create a Windows VM using the GUI and connect to it over RDP, and then over SSH.
This is largely similar to the Linux VM.
In the Azure portal:

1. Go to the `Virtual Machines` tab.
2. Click `+ Create` and choose *Azure Virtual Machine*.

In the steps below, if an option isn't mentioned in the instructions just leave it at its default value in the Azure portal.


## Basics

In the *Basics* tab:

1. Set *Subscription* dropdown to **Azure for Students**.
2. In *Resource group* pick **lab_rg** that you created above.
3. Moving on to **Instance details** set the *Virtual machine name* to `lab-windows`.
4. *Region* should be **(Europe) West Europe**.
5. Under *Availability options* choose **No infrastructure redundance required**. This is very important for now!
6. For **Image** choose `Windows Server 2022 Datacenter: Azure Edition - x64 Gen2` from the dropdown.
7. VM architecture should automatically set to **x64**.


###  Basics VM sizing

Very important!
It's very easy to accidentally pick the wrong (usually very expensive!) size of VM.
Take your time doing this part!

Under **Size** hit *See all sizes* and look for **B2s**.

When you've selected it it should say:

	Standard_B2s - Standard B2s (2 vcpus, 4 GiB memory)
	
*Windows VMs are more expensive than Linux ones due to licensing cost!*
	

### Administrator account

For the Administrator account settings, we'll create an initial username and password for the machine.
Don't use your DkIT (or other) credentials here, but make sure that you remembe the values set.
We will destroy the VM at the end of today's lab.


The username can be anything valid for a Windows machine, suggest `developer`.

Fill in your chosen Password and Confirm it. 
You won't be able to access this value again.


### Inbound port rules

For *Public inbound ports* choose **Allow selected ports**.

The *Select inbound ports* will auto-populate with **RDP (3389)** by default, which is what we need.


Hit `Next : Disks` to go on to the next page.

## Disks

On the Disks page we can leave everything alone.
Once the page has loaded fully hit `Next : Networking` to go on to the next page.


## Networking

Exactly as with Disks, we can leave everything on the networking page alone.

Once the page has loaded fully hit `Next : Management` to move on.


## Management

Again, we'll leave everything alone here.
Once the page has loaded fully hit `Next : Monitoring` to move on.


## Monitoring

Again, we'll leave everything alone here.
Once the page has loaded fully hit `Next : Advanced` to move on.


## Advanced

Again, we'll leave everything alone here.
Once the page has loaded fully hit `Next : Tags` to move on.


## Tags

Same again, we'll leave everything alone here.
Once the page has loaded fully hit `Review and Create` to move on.


## Create

Finally you can hit the blue **Create** button to create your VM.



# Task 4: Find VMs public IP address

Windows machines are primarily managed by RDP, which provides access to the desktop session. 
Linux, and increasingly Windows, machines are also managed remotely using SSH.

## Using the Azure Portal

Find your Virtual Machine the azure portal listing of virtual machines, and look for the Public IP address.

## Using the Azure CLI

We'll also find your Public IP using the Azure CLI.
To understand this command better, try using:

	az vm list
	
This is a lot of output. 
We could either use PowerShell's capabilities to sort this or query for exactly what we need:

	az vm show -d -g lab_rg -n lab-windows --query publicIps

This will get us just the information about the machine itself.
We can use a modified version of the command to just output the Public IP:

	az vm show -d -g lab_rg -n lab-windows --query publicIps 
	
If you want to get rid of the quotes (because this is a degenerate JSON document), you can use:

	az vm show -d -g lab_rg -n lab-windows --query publicIps -o tsv

You'll get the IP address.
You can either copy it with the mouse or pipe the IP directly into the Windows Clipboard.

	az vm show -d -g lab_rg -n lab-windows --query publicIps -o tsv | Set-Clipboard
	
*Some of these PowerShell operations might seem tedious, but it's worth knowing how to build up commands. Once you know what it's doing in future you can always skip to this last version!*
	
	
# Task 5: Connect to your VM

Search in the Start menu for  *Windows Remote Desktop*.

Paste the IP address into the box.

Use the username and password you previously created to login.

You will have to hit Yes on the certificate warning screen.

You'll finally see the Windows login progressing.
In my experience Windows VMs can be slow to start (just as in AWS) on the smaller machine sizes.
Eventually the Windows Server desktop will show.

*Well done on creating your first Windows VM on Azure.*


# Task 6: Enable SSH server on VM

Windows can be managed using SSH, which is often more convenient than running an RDP session.
It also allows an estate of Windows and Linux servers to be managed and automated together.

You can install OpenSSH server using the Install Windows Feature in the GUI or PowerShell on the guest VM.
However, you can also use Azure's management portal's *SSH extension* to do this for you!


## SSH extension

We'll follow [the instructions from Microsoft](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/connect-ssh?tabs=azurecli) on how to do this.
The Azure guides are unusually well done (compared to AWS)!

	az vm extension set -g lab_rg --vm-name lab-windows --name WindowsOpenSSH --publisher Microsoft.Azure.OpenSSH --version 3.0
	

## Test connectivity locally on the VM

First we'll try to connect using SSH to the VM itself.
Open PowerShell and type:

	ssh developer@127.0.0.1
	
If it even asks for your password your server is running.
	

## Test connectivity from your lab PC

Try to connect using SSH on your client PC:

	ssh developer@ip-address-here
	
It won't work! 


# Task 7: Network security rules

We'll now modify the network security rules to permit access via SSH.
This is by way of adding a new rule to the Network Security Group. 

To do this, issue the command: 

	az network nsg rule create -g lab_rg --nsg-name lab-windows-nsg -n allow-SSH --priority 1000 --source-address-prefixes 0.0.0.0/0 --destination-port-ranges 22 --protocol TCP

Now try to connect over SSH and login again using the command:

	ssh developer@ip-address-here
	

# Task 8: Change default shell
	
Notice that you're not actually in PowerShell, instead you're at the old Command Prompt.
You can start powershell by simply typing

	powershell
	
Notice that the prompt now changes to the familiar PowerShell prompt and all commands work as expected.


## Changing default shell

We can make Windows go straight to PowerShell on connection by issuing the command on the VM: 

	New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String  -Force
	
This very long command sets a *registry key* that controls what OpenSSH server does first in response to a new connection. 

**Without closing your first SSH session** open a new Tab/Window in Windows Terminal and make a *second* SSH connection to your VM.
It should now open directly with PowerShell (identifiable by the `PS` in the prompt).



# Task 9: Delete lab resources

**VERY IMPORTANT** Delete all resources once you're finished using them to save your Azure credits!  You're entirely responsible for managing your credits!

Delete the lab resource group from the CLI using:

	az group delete -n lab_rg

You should notice the RDP session (if open) terminates, the SSH connection(s) if open terminate(s). 
Once the command has finished then confirm that the resource group is gone in the Portal.

