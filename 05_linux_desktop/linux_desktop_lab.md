% Linux desktop lab

**Note:** A number of commands needed here aren't given.
You should refer back to previous labs.
Hopefully they'll soon be committed to your memory!

[Microsoft guide](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/use-remote-desktop?tabs=azure-cli)


# Task 0: Azure login

Log in to the Azure portal.

Make sure that the `az` command works.

	az account show
	
*I won't be repeating this part again!*


# Task 1: Create resource group

Use the CLI to create a resource group called `lab_rg` in the `westeurope` region. 

If you're not sure what command to use, just try

	az group 
	
and it'll show some helpful hints.


# Task 2: Create Linux VM

Follow the instructions from previous labs to create a Linux VM as follows.
The defaults are fine if not specified:

- **Resource group:** `lab_rg`
- **Virtual machine name:** `linux-desktop`
- **Availability options:** No infrastructure redundancy required
- **Image:** Ubuntu Server 24.04 LTS - x64 Feb2
- **Size:** Standard_B1s - 1 vcpu, 1 GiB memory
- **Authentication type:** Password
- **Username:** `developer` 
- **Password:** *one you'll remember*

You can then go straight to **Review and Create** and hit the **Create** button.

Save the IP address somewhere, suggest in Notepad and a PowerShell Variable called `$LinuxDesktopIp`. 


# Task 3: Confirm SSH connectivity

At this point you should test connectivity over SSH.

To make sure that the machine is listening on Port 22 you can use the following in PowerShell:

	Test-NetConnection -Port 22 -ComputerName $LinuxDesktopIp
	
You can then try ssh-ing to the machine

	ssh developer@$LinuxDesktopIp
	

# Task 4: Software Update

Use the standard commands to update the package list and perform any eligible upgrades:

	sudo apt -y update && sudo apt -y upgrade
	
The `-y` switch avoids a yes/no prompt.


# Task 5: Desktop installation

Unlike Windows or Mac, Linux has a number of options for desktops.
The choice can be complicating in itself.
Multiple desktop managers can even be installed at the same time, with the login user determining which one operates.

## Desktop manager

We're going to install a very basic desktop manager, [xfce](https://www.xfce.org/), that is light on resources and does not require too much configuration.

	sudo apt -y install xfce4
	
The installation could take a few minutes. 
	
## Session manager
	
Then we'll install the *session manager* which provides the login screen:

	sudo apt -y install xfce4-session



# Task 6: XRDP

Just as we use `sshd` to expose the shell over a network, we'll use a program called `xrdp` to expose graphical desktop sessions over the Microsoft RDP protocol.
There are a few ways to provide remote access to the physical console (same as monitor, keyboard, mouse) or virtual desktop sessions on Linux, including VNC.
RDP is handy if you want to connect from Microsoft Windows clients as the client is installed by default.

## Install XRDP server

Install the `xrdp` package

	sudo apt -y install xrdp
	
## Enable the RDP server

Enable the RDP server to start on boot

	sudo systemctl enable xrdp
	

## SSL access

XRDP uses SSL certificates and needs to be in the linux group to enable it to access them:

	sudo adduser xrdp ssl-cert
	


## Check XRDP status

XRDP runs as a *system service* in Linux.
We can check its status using:

	systemctl status xrdp
	
It should say `active (running)`.


## Restart XRDP

Let's restart XRDP so it picks up changes:

	sudo systemctl restart xrdp
	

# Task 7: Firewall changes

RDP runs on port 3389.

## Test connectivity

First let's use Test-NetConnection from our client PC to check if the RDP server is accessible:

	Test-NetConnection -Port 3389 -ComputerName $LinuxDesktopIp
	
If this works it should say `TcpTestSucceeded : True`.
It probably won't.


## Open port

We can use a simpler command than before to open a port to the relevant machine: 

	az vm open-port --resource-group lab_rg --name linux-desktop --port 3389

*This isn't the most secure configuration!*


## Check connectivity again

Re-try the `Test-NetConnection` from above.  It should now say: `TcpTestSucceeded : True`.

Don't move on until it does!


# Task 8: RDP login

Open *Remote Desktop Connection* and put in your Linux machine's IP address.

Put in the username and password at the prompt that opens.
You'll then see (hopefully!) a Linux desktop running the XFCE4 environment which is similar enough to Mac or Windows.


## Second login

Test what happens if you leave the session open and login again as the same user.


# Task 9: Second user

Linux (and Windows) are inherently multi-user systems.
We can make a second user account 

	sudo adduser tester
	sudo usermod -aG sudo tester
	sudo passwd tester
	
	
## SSH in as tester user

Make a new SSH connection as the `tester` user:

	ssh tester@$LinuxDesktopIp
	
Then put the XFCE4 session in the `.xsession` file.
	
	echo xfce4-session >~/.xsession


# Important: delete resources

Delete the resource group!
Command is: 

	az group delete -n lab_rg
	
Answer `y`, **wait for it to finish**.
Confirm in the GUI that the resource group has been deleted.

