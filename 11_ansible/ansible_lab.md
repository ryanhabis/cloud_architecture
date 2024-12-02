% Servlet deployment lab

This time we'll use *two* configuration utilities:

1. `cloud-init` on Machine bootup to do some very basic installation
2. `ansible` to deploy our app and its configuration



# Task 1: VM setup

Use the CLI to create `lab_rg` resource group. (You should know the command by now!)

Use the CLI to create a Linux VM:

	az vm create --resource-group lab_rg -n web-vm --image Ubuntu2204 --custom-data vm_config.yml --admin-user developer --admin-password 1Password2024. --size Standard_B2s

Open Port 8080

	az vm open-port -g lab_rg -n web-vm --port 80


# Task 2: Upload files

Upload the following files to the VM using SFTP:

	inventory.ini
	vm_playbook.yml
	mailing_list/target/mailing_list-1.0.war


# Task 3: Run ansible setup playbook

We'll now run the playbook:

	ansible-playbook -i inventory.ini vm_playbook.yml
	
This could take a while, but you should see the task being queued for execution.
When complete the command will return.

When it completes, repeat the command.
Look carefully at the `PLAY RECAP` - is it the same?


# Lab submission

In `lab07` folder include the following files to show you've completed the lab: 

- `inventory.ini`
- A playbook in `.yml` format that you used.
- `ansible_output.txt` showing clearly ansible output from the hosts in the inventory file

