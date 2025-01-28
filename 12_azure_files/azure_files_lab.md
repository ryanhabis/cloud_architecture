% Azure files lab

Today we'll be working with [Azure files](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction).

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


# Task 5: Connect to the Windows VM over RDP

Use RDP to connect to the Windows VM over its public IP address and the username / password combination you set.



# Task 6: Enable and connect over SSH

Although recent Windows versions have a fully functional SSH server available, it needs to be installed, enabled and started.

This can be done using PowerShell commands.
We'll however do it the "Azure way" using the extensions feature.

To do this navigate to the *Extensions + applications* page on the VM in the portal.
Hit *Add*.
Note there are quite a few extensions available!

Search for `SSH` and click into the *OpenSSH for Windows*.
Click the *Next* button at the bottom of the screen and then click *Review + create*.
On the final screen hit *Create*.
(You may wonder why there are 3 almost blank screens to navigate through. Some extensions do have configuration parameters to be entered.)

Now try to connect over SSH.
*The aim of this lab is to look back also at previous labs, so I won't give the command(s) here!*


# Task 7: Map the Azure file share to a Windows drive

We're going to try and connect drive `N:` to the file share we created earlier.


## Map network drive

To do this, navigate to your `labfs` fileshare in the Azure portal and select Connect.

- **Drive letter**: `N:`
- **Authentication method**: Storage account key

Then hit **Show script**. 
This will reveal a PowerShell script (a much smarter way than a set of instructions!)
On this hit the copy button. 

Paste into your VM's PowerShell window.
You might need to hit enter a few times. 

According to Microsoft:

- This script will check to see if this storage account is accessible via TCP port 445, which is the port SMB uses.
- If port 445 is available, your Azure file share will be persistently mounted.
- Your organization or internet service provider (ISP) may block port 445, however you may use Azure Point-to-Site (P2S) VPN, Azure Site-to-Site (S2S) VPN, or ExpressRoute to tunnel SMB traffic to your Azure file share over a different port.


## Confirm drive mapped

In PowerShell change into Drive `N:`.


## Test file operations

List out the files. 
Can you see the file(s) you uploaded earlier? 

Make a folder called `uploaded` and move all the files into it using the VM's PowerShell window.



# Task 8: Set up a Ubuntu Linux VM

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
6. For **Image** choose `Ubuntu Server 24.04 LTS - x64 Gen2` from the dropdown.
7. Set VM architecture **x64**.


###  Basics VM sizing

Under **Size** hit *See all sizes* and look for **B1s**.

When you've selected it it should say:

	Standard_B2s - Standard B2s (1 vcpus, 1 GiB memory)
	

### Administrator account

For the Administrator account settings, we'll create an initial username and password for the machine.
Don't use your DkIT (or other) credentials here, but make sure that you remembe the values set.
As usual, we'll destroy the VM at the end of today's lab.

The username can be anything valid for a linux machine, these instructions assume `developer`.

Fill in your chosen Password and Confirm it. 
You won't be able to access this value again.


### Inbound port rules

For *Public inbound ports* choose **Allow selected ports**.

The *Select inbound ports* will auto-populate with **SSH (22)** by default, which is what we need.


Hit `Review + Create` to move on.


## Create

Once *Validation passed* appears you can hit the blue **Create** button to create your Linux VM.


# Task 9: Login to the Linux VM

Use SSH to connect to the Linux VM.
Leave the SSH session open and move on to the next task.


# Task 10: Drive mapping

Linux machines have a single-root filesystem, whereas Windows is multi-root (has drive letters).
Recall that in linux to mount a virtual filesystem of any sort (such as a network filesystem), we create a folder called a *mountpoint* which we then "cover up" with the mounted filesystem.


## Getting the mount command

As before, navigate to your `labfs` fileshare in the Azure portal and select Connect.
This time click the *Linux* tab.
Leave prefilled values: 

- **Mount point**: `labfs`

Then hit **Show script**. 
This will reveal a bash script (again, a much smarter way than a set of instructions!)
On this hit the copy button. 


## Running the mount command

Paste into your SSH-connected VM.
You might need to hit enter a few times. 

Note the message you'll probably get relating to *systemd*.
Do as suggested, by running:

	sudo systemctl daemon-reload
	

## Checking is the drive mounted

To show all mounted filesystems use the `mount` command on its own:

	mount
	
You'll see quite a long list including the VMs "disk" and a number of local virtual filesystems like `/proc`.
To get bash to show `labfs` on its own we can use:

	mount | grep labfs


This should show that our Azure file share is mounted at, or available on, `/mnt/labfs`.


## Test file operations

Change into the `labfs` directory

	cd /mnt/labfs

List out the files in it

	ls
	
Try the same command in detail form (use the `-l` switch). 
What does the file ownership indications tell you? 



# Task 11: Experiment

I highly recommend that you take the opportunity to test out some operations on the filesystem now concurrently accessible from Linux VM, Windows VM and directly from the Azure portal. 

Do you see any opportunities for using this architecture in your own work? 


# Task 12: Delete

When you've finished, delete your VMs and the azure filesystem.
As usual, deleting the resource group is by far the easiest and most reliable way.
To confirm deletion works, best to leave the RDP and SSH sessions to the VMs open while you delete them - they should disconnect!

One thing you'll find is that the Azure file share is protected by a *Lock* that prevents deletion.
To remove the lock, navigate to your storage account, Settings, Locks and delete the lock.
Then try the deletion command again.

	az group delete -n lab_rg
	
	
