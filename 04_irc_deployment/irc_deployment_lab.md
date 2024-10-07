% IRC Deployment Lab


This lab will be a bit harder than previous labs - you will not be given the commands needed if you've seen them before!


# Task 1: Azure login

Make sure you can login to the [Azure portal](https://portal.azure.com) with your DkIT credentials.

Also make sure that the `az` command functions correctly by using:

	az account show
	

# Task 2: Resource group creation

Use the Azure CLI to create a Resource Group named `lab_rg` located in Europe (West) as we've done in previous labs.
See Windows VM Lab Task 2 to remind you.


# Task 3: Linux Server setup

Use the instructions from Linux VM Lab Tasks 7-9 to create a Linux VM named `lab-linux` and connect to it over SSH.

**Note:** you can skip straight to the Review and Create step after the first page.

Note down its IP address.


# Task 4: Install IRC server on Linux

Log into the linux VM over SSH.

## Software update

Update the software repository list and installed packages using:

	sudo apt -y update && sudo apt -y upgrade
	
	
## Install IRC server

We're going to install the `ngircd` IRC server on the linux machine.

To do this run:

	sudo apt -y install ngircd
	
*Question:* can you see how you'd combine the installation commands with the ones above?


# Task 5: Install IRC client on linux

Log into the Linux server on a second SSH connection.

We're going to install a text-based IRC client on Linux, here `irssi`.

Use the example above from `ngircd` to write the command to install `irssi`. 


# Task 6: Test IRC works on localhost

Launch `irssi` using the command:

	irssi
	
This will open a full-screen application.
IRC normally accepts commands in text form.

## Connect to local server

To connect to localhost, we type:

	/CONNECT 127.0.0.1
	
If `ngircd` is working you should see a message that ends with `End of MOTD command` or similar.

By default there is no authentication.
(It can be setup on the server if needed.)


## Join a channel

Let's now join a channel.
IRC servers sometimes have channels pre setup on them.
Just as with the loose authentication options, by default IRC servers permit any user to create a channel.
Let's do that now:

	/JOIN #GENERAL
	
Note the hash tag before the channel name, just as used in modern social media.


# Task 7: Tunneling SSH

SSH has a *very* handy feature called **Tunnelling**.

Tunnelling lets us open a port on our local machine and *forward* it to the remote machine (or any machine on the remote machine's network).
It's almost like a mini VPN.
Tunnelling can co-exist with a normal interactive login session.

Open a new SSH session to your `lab-linux` machine using:

	ssh -L6667:127.0.0.1:6667 student@linux-ip-address-here

The `-L` option opens port 6667 (the standard IRC port) on the local machine and forwards it to the remote machine, where it will send traffic to 127.0.0.1 (itself) on port 6667.


# Task 7: Installing IRC on local PC

[Install MIRC](https://www.mirc.com/get.html)

## Configuration

When it opens go to Server dropdown and click the button beside it, then Add.

	Description: localhost
	Address: 127.0.0.1
	
Leave everything else alone and click `OK`.  

## Connection

Drop down your new Server setting in the list.
Put `lab` in the Nickname.
Hit `Connect` .

You should see a similar message in MIRC as you saw in `irssi`.
Close the Favourites window that pops up.

# Joining Channel

You can browse channels etc in the GUI but the same commands also work here.
In the command box type

	/JOIN #GENERAL
	
Look at your linux box and notice that it shows the `lab` user has joined.


# Try out chat

At this point you can type messages in the command window which will fill up in the chat just like WhatsApp / Teams etc.


# Task 8: Windows setup

Just as with the Linux machine, use Tasks 3 and 4 to setup `lab-windows` and get its IP address.

Note that by default it will be in the existing VNet `lab-linux-vnet` which is what we want.

Connect to `lab-windows` over RDP.

[Install MIRC](https://www.mirc.com/get.html)

## Confirm connectivity

Confirm that you can SSH from Windows To the Linux machine using the Private IP addresses.


## Configuration

Run MIRC.
When it opens go to Server dropdown and click the button beside it, then Add.

	Description: lab-linux
	Address: IP of linux machine here
	
Leave everything else alone and click `OK`.  

## Connection

Drop down your new Server setting in the list.
Put `windows` in the Nickname.
Hit `Connect` .

The connection will fail because we need to add a rule in the network security group.

# Task 9: network security group changes

Look back at the changes in the Network security group made in Windows VM Lab Task 7.
Use the command to add a rule to the **LINUX** VM to permit connections on port 6667.

	az network nsg rule create -g lab_rg --nsg-name lab-linux-nsg -n allow-IRC --priority 1000 --source-address-prefixes 0.0.0.0/0 --destination-port-ranges 6667 --protocol TCP

## Try reconnecting

You should see the similar message in MIRC as you saw in `irssi`.
Close the Favourites window that pops up.

## Joining Channel

You can browse channels etc in the GUI but the same commands also work here.
In the command box type

	/JOIN #GENERAL
	
Look at your linux box and notice that it shows the `lab` user has joined.


## Try out chat

At this point you can type messages in the command window which will fill up in the chat just like WhatsApp / Teams etc.


# Delete all resources

When you've finished the lab, delete all resources by deleting your resource group!

**VERY IMPORTANT** Delete all resources once you're finished using them to save your Azure credits!  You're entirely responsible for managing your credits!

Delete the lab resource group from the CLI using:

	az group delete -n lab_rg

You should notice the RDP session (if open) terminates, the SSH connection(s) if open terminate(s). 
Once the command has finished then confirm that the resource group is gone in the Portal.

