% Azure files lab

This lab is based on the [Tutorial: Create an SMB Azure file share and connect it to a Windows VM using the Azure portal](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-quick-create-use-windows)

# Task 0: Login

Open the [Azure portal](https://portal.azure.com) in your browser.

Make sure that you are logged in at the CLI using:

	az account show
	
	
# Task 1: Resource group

Use the CLI to create the `lab_rg` resource group in `westeurope` region.


# Task 2: Create storage account

First we'll create a *storage account* to group storage in for this lab.

Azure Storage accounts require names to be globally unique across Azure.
We've met this before when we look at AWS S3 buckets.
(Despite the similarity around names, storage accounts are a higher level of abstraction than AWS S3 buckets themselves.)

- **Subscription**: Azure for Students
- **Resource group**: `lab_rg` 
- **Storage account name**: *enter your choice of name here once it follows the rules*
- **Region:** (Europe) West Europe
- **Primary service**: Azure files
- **Performance**: Standard
- **File share billing**: Pay-as-you-go file shares
- **Redundancy**: Locally Redundant Storage (LRS)

For now go straight to **Review + create**, and on that screen hit the blue **Create** button.


# Task 3: Create a file share

Navigate through the resource group to your newly created storage account.
Under *Data storage* look for *File shares*.

## New file share

Click *New file share*.

Under *Basics* use the **Name** `labfs`.
Leave the *Access tier* set to `Transaction optimised`.

On the Backup page turn off *Enable backup*.

Continue on to **Review + create**, and on that screen hit the blue **Create** button.

## Upload file

We'll now try to upload a few files to your file share directly from our client.

On the file share location, select *Upload*.

Browse to any file (you can use this one!).

Repeat for a few files.


# Task 4: Create a Windows VM

First we'll create a Windows VM to access our Azure storage.
In the Azure portal:

1. Go to the `Virtual Machines` tab.
2. Click `+ Create` and choose *Azure Virtual Machine*.

In the steps below, if an option isn't mentioned in the instructions just leave it at its default value in the Azure portal.


## Basics

In the *Basics* tab:

1. Set *Subscription* dropdown to **Azure for Students**.
2. In *Resource group* pick **lab_rg** that you created above.
3. Moving on to **Instance details** set the *Virtual machine name* to `windows-vm`.
4. *Region* should be **(Europe) West Europe**.
5. Under *Availability options* choose **No infrastructure redundance required**. This is very important for now!
6. For **Image** choose `Windows Server 2022 Datacenter: Azure Edition - x64 Gen2` from the dropdown.
7. VM architecture should automatically set to **x64**.


###  Basics VM sizing

Under **Size** hit *See all sizes* and look for **B2s**.

When you've selected it it should say:

	Standard_B2s - Standard B2s (2 vcpus, 4 GiB memory)
	

### Administrator account

For the Administrator account settings, we'll create an initial username and password for the machine.
Don't use your DkIT (or other) credentials here, but make sure that you remembe the values set.
As usual, we'll destroy the VM at the end of today's lab.

The username can be anything valid for a Windows machine, these instructions assume `developer`.

Fill in your chosen Password and Confirm it. 
You won't be able to access this value again.


### Inbound port rules

For *Public inbound ports* choose **Allow selected ports**.

The *Select inbound ports* will auto-populate with **RDP (3389)** by default, which is what we need.


Hit `Next : Disks` to go on to the next page.

Once the page has loaded fully hit `Review + Create` to move on.


## Create

Once *Validation passed* appears you can hit the blue **Create** button to create your VM.


## Task 5: Connect to the Windows VM over RDP

Use RDP to connect to the Windows VM over its public IP address and the username / password combination you set.  

