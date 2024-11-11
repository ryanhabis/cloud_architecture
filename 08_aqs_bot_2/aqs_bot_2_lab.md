% AWS Bot 2 lab

# Task 1: Resource group creation

Create your `lab_rg` .


# Task 2: Create storage account

Same as last week.


# Task 3: VM creation

Follow the process we've used to date to create a new Ubuntu VM on B1s size. 

Paste the provided `vm_config.yml` (similar to last week) into the *custom data* box.


# Task 4: Build TeamBot project

Build TeamBot in Netbeans. 


	
# Task 5: Connection string

Follow last week's instructions to get the Connection string for your Storage account.
Copy it and put it in a txt file on the Desktop or somewhere convenient.

Also On your VM open run the command

	nano connection_string.txt
	
Paste the connection string into the text editor, save and exit.
	

# Task 6: Create SSH tunnel for local testing

Connect to your VM with a port forward for the IRC server.

	ssh -L 6667:127.0.0.1:6667 developer@your-ip-here
	
Check that TeamBot works OK on your local machine. 


# Task 7: Run the qprocessor.ps1 on the local machine 

In PowerShell

	./qprocessor.ps1 connection-string-here


# Task 8: Transfer TeamBot to server

Use: 

	sftp developer@your-ip-here

to connect to the VM. 

Transfer the TeamBot to the VM. 
	

	
	
# Run TeamBot

We're going to use TMUX to divide the Window in two, with TeamBot on the right and the chat client on the left.
Start tmux by typing

	tmux
	
## IRSSI client
	
Then run irssi

	irssi
	
Connect to the local server and the channel by running

	/CONNECT 127.0.0.1
	/JOIN #general
	
## Split the window
	
Now split the TMUX window into 2 panes by typing

	Ctrl-B %
	
## Run TeamBot
	
In the right-hand pane run the TeamBot 

	java -jar TeamBot.jar $(cat connection_string.txt)
	

# Install TeamBot as a service

Copy the teambot.service file into `/etc/systemd/system` folder on the VM.


## Reload service unit files

	sudo systemctl daemon-reload
	
## Enable service

	sudo systemctl enable teambot
	
## Start service

	sudo systemctl start teambot
	
## Confirm TeamBot is running

	systemctl status teambot
	

# Queue Processor

Run the qprocessor.ps1 and confirm that it prints out orders sent to it by the bot.

