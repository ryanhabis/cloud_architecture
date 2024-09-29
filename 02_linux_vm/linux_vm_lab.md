% Azure Linux VM intro lab

In this lab we'll take a basic introduction to Compute Instances on Azure.
From previous work in AWS, where we've used both the *console* and the *cli* we'll make use of both modes of interaction with Azure today.
We will mainly use the GUI, supported by the CLI in a few places.

Make sure you have signed up for Azure free credits, as per previous lab.


# Task 1: Login to Azure on the web

Login to [the Azure portal](https://portal.azure.com/#home) via the Web browser.

Use your DkIT credentials, which will require MFA.


# Task 2: Confirm student subscription on the web

Once logged into Azure portal, navigate to the [subscriptions](https://portal.azure.com/#view/Microsoft_Azure_Billing/SubscriptionsBladeV2) page.

Make sure you see *Azure for Students* as the only item in the subscription list.


# Task 3: Log into the CLI

Open Windows Terminal, and run the command

	az login
	
Use your DkIT login and follow the MFA prompts if asked.
When asked about the subscription to login to, type `1` and press Enter.
DkIT should be the only one shown.


# Task 4: Test if the CLI works

Open Windows Terminal, and run the command

	az account show
	
It should return some JSON that looks like:

	{
		"environmentName": "AzureCloud",
		"homeTenantId": "abcc9a4b-cf04-4ca3-9d83-3465e3f43f61",
		"id": "2ddf9cb8-8fdd-4a55-cd50-3ddda3744599",
		"isDefault": true,
		"managedByTenants": [],
		"name": "Azure for Students",
		"state": "Enabled",
		"tenantDefaultDomain": "studentdkit.onmicrosoft.com",
		"tenantDisplayName": "Dundalk Institute of Technology",
		"tenantId": "abcc9a4b-cf04-4ca3-9d83-3465e3f43f61",
		"user": {
			"name": "grantp@dkit.ie",
			"type": "user"
		}
	}
	
If you see this, then you're logged in OK.
Move on to the next task.


# Task 5: Create Resource Group

We'll begin creating a *resource group*, which lets us visually and logically group resources belonging to a particular project or workload.

1. Open the [resource groups](https://portal.azure.com/#browse/resourcegroups) page in the portal.
2. Hit the `Create +` button.
3. Set *Subscription* to **Azure for Students**.
4. Set *Resource group* (the name) as `lab_rg`.
5. Under *Resource Details* drop down *Region* to **(Europe) West Europe**.
6. Click *Next* to go to the tags screen (which we won't use).
7. Click *Next* again. You should see a green *Validation passed.* message at the top.  Your resource group hasn't been created yet!
8. Click **Create** at the bottom left (not the most intuitive place!).

You will now be returned to the *Resource groups* page and see your new resource group shown in the list.


# Task 6: Use CLI to list resource groups

In Windows Terminal / PowerShell run the command

	az group
	
It will show a list of subcommands.
Run the appropriate subcommand to list the resource groups in your account.
Does it correspond to the list shown on the web?


# Task 7: Create a Linux VM

First we'll create a Linux VM using the GUI and connect to it over SSH.
This is a similar enough process to AWS but the default Networking configurations mean that there is a lot less housekeeping needed by default.
In the Azure portal:

1. Go to the `Virtual Machines` tab.
2. Click `+ Create` and choose *Azure Virtual Machine*.

In the steps below, if an option isn't mentioned in the instructions just leave it at its default value in the Azure portal.


## Basics

In the *Basics* tab:

1. Set *Subscription* dropdown to **Azure for Students**.
2. In *Resource group* pick **lab_rg** that you created above.
3. Moving on to **Instance details** set the *Virtual machine name* to `lab-linux`.
4. *Region* should be **(Europe) West Europe**.
5. Under *Availability options* choose **No infrastructure redundance required**. This is very important for now!
6. For **Image** choose `Ubuntu Server 24.04 LTS - x64 Gen2` from the dropdown.
7. VM architecture should automatically set to **x64**.


###  Basics VM sizing

Very important!
It's very easy to accidentally pick the wrong (usually very expensive!) size of VM.
Take your time doing this part!

Under **Size** hit *See all sizes* and look for B1s.

When you've selected it it should say:

	Standard_B1s - 1 vcpu, 1 GiB memory ($8.76/month) (free services eligible)
	

### Administrator account

For the Administrator account settings, we'll create an initial username and password for the machine.
Don't use your DkIT (or other) credentials here, but make sure that you remembe the values set.
We will destroy the VM at the end of today's lab.


In *Authentication type* choose **Password**.

The username can be anything valid for a Linux machine, suggest `student`.

Fill in your chosen Password and Confirm it. 
You won't be able to access this value again.


### Inbound port rules

For *Public inbound ports* choose **Allow selected ports**.

The *Select inbound ports* will auto-populate with **SSH (22)** by default, which is what we need.


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



# Task 8: Find VMs public IP address

Linux, and increasingly Windows, machines are generally managed remotely using SSH.

Find your Virtual Machine the azure portal listing of virtual machines, and look for the Public IP address.


# Task 9: Connect to the VM using SSH

Open a second PowerShell session (separate to the one you've used so far).
To do this, make a new Tab or Window in Windows terminal. 

In your new PowerShell session in Windows terminal run the command:

	ssh student@ip-address-here

You will see a message like:

	The authenticity of host '40.91.203.149 (40.91.203.149)' can't be established.
	ED25519 key fingerprint is SHA256:ttuJWpu8OULXt3iEMCVZv6L7n0puw7429kHYmtzB7Xc.
	This key is not known by any other names
	Are you sure you want to continue connecting (yes/no/[fingerprint])? yes

Type `yes` and press enter in response.

Enter your chosen password from above when prompted.

You should then recognise the linux prompt:

	student@lab-linux:~$ 
	

For today we won't do much in this VM, so we can type `exit` to quit the SSH session.


# Task 10: Deletion (important!)

**Very important** if you don't delete VMs and other resource you'll use up your Azure credits *very* quickly.

The best way to delete work from a lab (or other project) is to delete the resource group to which everything belongs.
This makes sure you haven't forgotten anything, which will be important when we do labs that involve 2 or more VMs.

Go to the *Resource groups* page and click into `lab_rg`.

You'll see a list of all resources in the resource group.

Hit **Delete resource group** at the top. 

Under *Enter resource group name to confirm deletion* type `lab_rg`.

Click the red **Delete** button and confirm with the red button in the dialog box.
