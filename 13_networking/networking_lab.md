% Azure networking lab

So far, we have used the (sensible) defaults for Azure Networking when we've created VMs. 
Unlike AWS, we don't have to understand quite as much about Azure's VNets to just get a basic Windows or Linux VM up and running.
In today's lab we will look at the basic Azure networking in more detail.

Also it's time to make greater use of the (in my opinion very good) vendor-provided guides.
In ways today's lab will point you towards them a bit more.


# Resource group creation

For today's lab use the CLI or Portal to create the usual `lab_rg` resource group located in `westeurope` region.


# VNet creation

Create a new vnet named `lab-vnet` within `lab_rg` using the portal or CLI with the range 10.0.0.0/16.


## Subnet creation

Delete the suggested *default* subnet.

Create a subnet named `lab-subnet` within the `lab-vnet` with the range 10.0.1.0/24.

In the portal the defaults should otherwise work fine.


# Network security group creation

Network security groups are broadly similar to AWS Security Groups.

Create a network security group in `lab_rg` named `lab-nsg` that permits RDP and SSH inbound from any IP address.


# VM creation

We're going to examine a standard linux and Windows VM during today's lab.

Use the instructions for previous labs so far to create one of each. 


## Linux VM

- **Image:** Ubuntu Server 24.04 LTS
- **Size:** B1s

On the networking page Virtual network drop down to `lab-vnet`, and not the default *(new)* selection.

Under NIC network security group select Advanced and pick `lab-nsg` (from above).

Turn on Delete public IP and NIC when VM is deleted.


## Windows VM

- **Image:** Windows Server 2022 Datacenter
- **Size:** B2s

Same as for the Linux VM, on the networking page Virtual network drop down to `lab-vnet`, and not the default *(new)* selection.

Under NIC network security group select Advanced and pick `lab-nsg` (from above).

Turn on Delete public IP and NIC when VM is deleted.


## Windows VM SSH server

Activate the OpenSSH server extension for Windows.


# Resource group deletion

Delete the resource group using the CLI and/or Portal.

