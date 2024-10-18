% Chat system lab


# Task 0: Login

Login to the [Azure portal](https://portal.azure.com/) and make sure that you can run the `az` command.
See previous labs if not sure how to do this.


# Task 1: Build the TeamBot program

On your lab PC, open the TeamBot program in NetBeans and Build the project.
It *should* build with no errors (checked 18/10/2024).


# Task 2: Resource group

Use the Azure CLI to create `lab_rg` lab resource group in the `westeurope` location (region).


# Task 3: Create the VM

Use the lab instructions from previous labs to create a *Ubuntu Server* VM in `B2s` size called `chat-vm`.

Do everything as before *except* when you arrive on the **Advanced** tab.


# Task 4: Installation script

We're going to use a *user data script* as we previously saw on AWS to install needed software and configure some things on the Machine without having to do it manually.

[Microsoft guide to user-data bash script on Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/cloudinit-bash-script)

Copy and paste the contents of `user_data.sh` into the custom-data text box.






