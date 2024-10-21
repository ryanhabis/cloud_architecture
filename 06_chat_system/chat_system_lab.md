% Chat system lab

Important links:
- [Azure guide to cloud-init customisation](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/tutorial-automate-vm-deployment
)

# Task 0: Login

Login to the [Azure portal](https://portal.azure.com/) and make sure that you can run the `az` command.
See previous labs if not sure how to do this.


# Task 2: Build IRC system from 2 weeks ago

Repeat lab from `04_irc_deployment` Tasks 1-6.


# Task 3: Build IRC system with cloud init

Delete your VM!

Re-do creation of VM and paste the contents of `vm_config.yml` into the **Custom Data** box on the *Advanced* page.

Log in and check that everything has been installed automatically.
This may take some time!


# Task 3: Build the TeamBot program

On your lab PC, open the TeamBot program in NetBeans and Build the project.
It *should* build with no errors (checked 18/10/2024).

Make sure you can understand roughly what the code does.


# Task 4: TeamBot locally on PC

On your lab PC open a new connection to your VM.

	ssh -L6667:127.0.0.1:6667 developer@your-ip-here
	
Run TeamBot in NetBeans by clicking Run. 
Test it out to see if it responds to `?coffee`.


# Task 5: Upload TeamBot to the server

On your lab PC open a new tab in Windows Terminal.
Navigate to the `TeamBot/target` folder (or use *Open in terminal* from File Explorer).

Open an SFTP connection to the VM:

	sftp developer@your-ip-here
	
Upload the JAR with dependencies and then exit: 

	put TeamBot-jar-with-dependencies.jar 
	exit
	

# Task 6: Run TeamBot on the server

In one SSH session make sure you have `irssi` client open and connected to the local machine and the `#general` channel open.
If not, go back to instructions above.

Open a second SSH session run the bot using

	java -jar TeamBot-jar-with-dependencies.jar 
	
Test that the bot works by going back to first session and running commands.


# Task 7: Bot as a system service

Change into the systemd/system folder

	cd /etc/systemd/system
	
Open a new service unit file:

	sudo nano teambot.service
	
Copy and paste in the contents of the `teambot.service` file from your lab PC.
Save using Ctrl-X, answer Y and press enter to quit.

Reload the service unit files

	sudo systemctl daemon-reload
	
Enable teambot on startup

	sudo systemctl enable teambot
	
Start teambot

	sudo systemctl start teambot
	
If you look over at your `irssi` client you should see TeamBot has joined the room.
Test it out as before.

Reboot the machine and confirm that it restarts TeamBot without any action from you.


