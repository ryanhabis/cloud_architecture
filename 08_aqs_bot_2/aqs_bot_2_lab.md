% Managed identities lab

[Managed identities guide](https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/how-to-configure-managed-identities?pivots=qs-configure-portal-windows-vm)

# Create storage account

Same as last week.


# VM creation

Follow the process we've used to date to create a new Ubuntu VM on B1s size. 

On the *Management* page turn on the option **Enable system assigned managed identity**.

Paste the provided `vm_config.yml` (similar to last week) into the *custom data* box.


# Build TeamBot project




# Transfer TeamBot to server

	sftp developer@your-ip-here

	
	
# Connection string

Follow last week's instructions to get the Connection string for your Storage account.
Copy it.
On your VM open run the command

	nano connection_string.txt
	
Paste the connection string into the text editor, save and exit.
	
	
	
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

