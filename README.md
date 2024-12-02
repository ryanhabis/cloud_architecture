Here’s a polished and professional version of your README file:

---

# Common Azure and SSH Commands

This guide includes commonly used commands for managing Azure resources and securely accessing virtual machines.

---

## **Azure CLI Commands**

### **Delete a Resource Group**
Use the following command to delete an Azure resource group and all its resources:
```bash
az group delete -n lab_rg
```
- `-n` specifies the name of the resource group to delete.
- **Caution:** This action is irreversible.

---

## **SSH Commands**

### **Log in to a Virtual Machine**
To establish an SSH connection to a virtual machine:
```bash
ssh developer@172.211.82.125
```
- Replace `developer` with your username.
- Replace `172.211.82.125` with your VM's public IP address.

---

## **SFTP Commands**

### **Log in via SFTP**
To securely transfer files to or from your virtual machine:
```bash
sftp developer@172.211.82.125
```
- Use the same credentials as SSH.
- After login, use SFTP commands like `put`, `get`, and `ls` to manage files.

---

### **Tips for Secure Connections**
1. Ensure your SSH private key has proper permissions:
   ```bash
   chmod 600 /path/to/private_key
   ```
2. Use a strong password or key-based authentication for secure access.
3. For frequently used connections, consider adding an alias in your SSH configuration file (`~/.ssh/config`).

---

If you have any questions or encounter issues, feel free to reach out or check the [Azure CLI documentation](https://learn.microsoft.com/en-us/cli/azure/) and [SSH manual](https://www.openssh.com/).

--- 

Let me know if you'd like to add additional sections, images, or formatting enhancements!
