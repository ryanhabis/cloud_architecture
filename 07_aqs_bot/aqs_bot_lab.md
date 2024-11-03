% Azure Queue Storage Bot Lab

The instructions below assume that you're logged into the Azure portal and can use the `az` command (test using `az account show` if needed).

[Microsoft guide to Azure queue storage](https://learn.microsoft.com/en-us/azure/storage/queues/storage-queues-introduction)


# Task 1: Create resource group

Use the CLI to create a `lab_rg` in `westeurope` region:

	az group create -l westeurope -n lab_rg
	

# Task 2: VM setup

Setup a VM with the following:

- **Resource group:** `lab_rg`
- **Virtual machine name:** `chat-server`
- **Availability options:** No infrastructure redundancy required
- **Image:** Ubuntu Server 24.04 LTS - x64 Gen2
- **Size:** B1s
- **Authentication type:** Password
- **Username:** developer

Click through to *Advanced* and paste in **custom data** from `vm_setup.yml`. 


# Task 3: VM login

Login to the VM over SSH with a local port forwarded for the IRC server: 

	ssh -L6667:127.0.0.1:6667 developer@your-ip-here 


# Task 4: Start tmux session

We're going to want to run a few things concurrently in our session.
Rather than making multiple SSH connections, we'll use `tmux` to manage our session.
Start tmux by typing

	tmux
	
You should now see a green bar down the bottom of the screen.
To disconnect from the tmux session you can type:

	Ctrl-B d
	
You'll be back out at the system prompt again.
Just type

	tmux attach

to re-attach to your session.


# Task 5: Connect to chat room

First let's use the `irssi` chat client to connect to our room.

	irssi
	
Then issue the commands

	/CONNECT 127.0.0.1
	/JOIN #general
	

# Task 6: Create azure storage account

Use the Azure portal to browse to *Storage accounts* and choose *Create a storage account*. 
On the creation page, leave the defaults as-is except for:

- **Resource group** should be `lab_rg`. 
- **Storage account name:** like S3 buckets has to be globally unique, so choose one that works (and note it down).
- **Primary service:** should be *Other (tables and queues)*.
- **Redundancy:** Locally-redundant storage.

You can skip immediately to *Review + create*.
Hit create.


# Task 7: Create Azure Storage Queue

Largely using [quickstart](https://learn.microsoft.com/en-us/azure/storage/queues/storage-quickstart-queues-portal) from Microsoft:

Navigate to your Azure storage account (you can find it in the `lab_rg` page), go to *Data storage* then *Queues*.

Hit the *+ Queue* button at the top.
Type `coffeeq` and hit Enter.

Like AWS, the queue has a textual identifier in the form of a URL.
Note the form of the URL.


# Task 8: Test out the Queue

Add 4 messages to the queue, with Base 64 encoding turned off, e.g.

	This is message 1
	
Then in PowerShell run the command

	az storage message get --account-name labstoragegrantp --queue-name coffeeq --auth-mode key
	
As with SQS delete using the `popReceipt` value:

	az storage message delete --account-name labstoragegrantp --queue-name coffeeq --auth-mode key  --id 91bd2fac-0970-475a-a721-87494273f0a7  --pop-receipt AgAAAAMAAAAAAAAAGMKfNXMs2wE=
	
	
# Task 9: Run the qprocessor.ps1

Run the provided `qprocessor.ps1` script and let it run.

	./qprocessor.ps1
	
Add a few messages to the queue and make sure that the `qprocessor.ps1` receives them.


# Task 10: Build the IRC bot

There's a new version of TeamBot this week.

Open NetBeans and build (not run) the project!


