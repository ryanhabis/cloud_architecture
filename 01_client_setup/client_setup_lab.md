% Cloud Architecture Client Setup Lab

The aim of this lab is to set up your client environment in the lab.
I recommend that you use the same computer each session as some configuration files and key pairs need to be placed in the appropriate folders.
However I have also provided scripts to copy these to/from OneDrive assuming that you've set it up.


# Task 1: Git repository

Ensure that you have a copy of the Git repository for the module in a location *not managed by OneDrive*.
Make sure that it is up to date by running:

	git pull --rebase
	
	
# Task 2: Enable script execution

Open Windows Terminal.
Make sure that it's a PowerShell (not cmd) terminal by ensuring the `PS` prompt is visible on the left.
Navigate to this `01_client_setup` folder.
(Hint: you can copy the path in Windows 11 by right-clicking the `01_client_setup` folder and `cd` into it. 

We will use PowerShell (and other) scripts a lot in this module.
PowerShell scripts are restricted by default in Windows.
To check if your user account on this PC permits PowerShell script execution try running the test script provided by typing:

	./test_script.ps1
	
You should see a message printed in Green.
If not then run:

	Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
	
Close and re-open PowerShell.
Navigate back to this `01_client_setup` folder.
Make sure that the test script `./test_script.ps1` now runs.
Don't move on to the next task until this works.
	

# Task 2: Client software check

We will now run a script to check that your client PC has all the needed software.
The specialist lab PCs should pass these checks - if they don't you need to let me know and we will raise a ticket.
Nevertheless, we'll confirm anyway as sometimes software can be missing or not accessible.

Run the script:

	./client_check.ps1

Make sure that it prints a message in green that the PC has all required packages installed for completing this module.
If it does not, stop and let me know.


## Working from home or own device

If you want to work at home you can use this (or `client_check.sh` on Mac / Linux) to verify that your system has all required packages.
The script will give the links to download required software.

In terms of expectations, I only can support use of lab PCs and cannot troubleshoot your home or mobile configurations.
In theory most of the configuration here should work on home / mobile devices but I can't guarantee it. 


# Task 3: XOA setup

We may use XOA at some stages in the module to demonstrate some concepts at a lower cost than the commercial cloud platforms and explore private cloud environments.

## Check that XOA works

Make sure that you can log into XOA.
If you see the `New VM` button then move on ahead to the next task.
If not, request permissions as in next section.

## XOA permission request

To request permissions to XOA visit https://xoarequest.comp.dkit.ie/ .
The technical staff will review requests and grant permissions.


# Task 4: SSH keys

You previously have encountered SSH keys for connecting to remote machines, and in the case of AWS for decrypting Windows VM passwords.
Keys can be encrypted and therefore protected by a passphrase. 
We will for now not use this, but you can do so if you like. 
Just don't forget your Passphrase!

In some exercises we'll use alternative key pairs that we'll generate on-demand as needed.


## Generate ED25519 key pair

ED25519 key pairs are best for logging into Linux instances.
Your ED25519 key pair can be created by running the command:

	ssh-keygen -t ed25519
	
Just hit enter to accept all the defaults.
You may have to enter *Yes* to overwrite the existing key(s) if they exist.
Your SSH key pair will be stored in *two* files in the `.ssh` subdirectory of your home folder: 

- `id_ed25519` stores the private key
- `id_ed25519.pub` stores the public key

	
## Generate 2048-bit RSA key pair

AWS uses SSH key pairs to securely provide the password for Windows instances as standard.
Unfortunately these use 2048-bit RSA keys.
We'll generate one here using the command:

	ssh-keygen -t rsa -b 2048 

As before, just hit enter to accept all the defaults.
You may have to enter *Yes* to overwrite the existing key(s) if they exist.
Your SSH key pair will be stored in *two* files in the `.ssh` subdirectory of your home folder: 

- `id_rsa` stores the private key
- `id_rsa.pub` stores the public key


# Task 5: Microsoft Azure acount setup

We'll also use Microsoft Azure in this module using the free credit for students offer.
[Sign up to Azure by visiting this link](https://azure.microsoft.com/en-us/free/students) and logging in with your *DkIT* credentials.
You should use your full DkIT credentials to login.

## Azure console

After signing up, make sure you can see the Azure web console.
Like AWS we'll use it to begin with. 

## Azure CLI

Setting up the Azure CLI is much easier than AWS.
Just run the command:

	az login
	
Which will initiate first a graphical authentication flow, and will then let you select the required *subscription*.
Make sure to choose the one that states `Azure for Students` and tenant `Dundalk Institute of Technology`:

	[Tenant and subscription selection]

	No     Subscription name    Subscription ID                       Tenant
	-----  -------------------  ------------------------------------  -------------------------------
	[1] *  Azure for Students   2ade98b8-837d-4d50-b5a0-fda27c7eb599  Dundalk Institute of Technology

	The default is marked with an *; the default tenant is 'Dundalk Institute of Technology' and subscription is 'Azure for Students' (2ade98b8-837d-4d50-b5a0-fda27c7eb599).

	Select a subscription and tenant (Type a number or Enter for no changes): 1
	
If you have multiple subscriptions shown you'll need to type the correct number for the `Dundalk Institute of Technology` subscription.
It should then confirm: 

	Tenant: Dundalk Institute of Technology
	Subscription: Azure for Students (2ade98b8-837d-4d50-b5a0-fda27c7eb599)


## Confirm az cli works

To confirm your Azure CLI works you can run the command:

	az account show
	
It should print out your basic account information in JSON format. 


# Task 6: AWS account setup

We will also use an AWS account in this module.
You previously have used an AWS account in Cloud Foundations and Cloud Technologies.

## Log into AWS Console on the web

Make sure that you can log into your AWS account on the website.

## Confirm AWS account works on the console

You can use any AWS command you like that requires authentication.
I often use:

	aws sts get-caller-identity
	
which just prints your account information.
