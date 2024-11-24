% CA1 specification

**DRAFT** for class discussion. 

**Weight:** 20%

**Deadline:** to be confirmed

# Summary

You are to host a service of your choice on the Azure platform using primarily IaaS components (e.g. VM, VNet).

It is recommended, but not mandatory, that you use a Java JSP/Servlet application backed by a database.
Whether you use a Windows, Linux (or other OS) VM is entirely up to you.

# Deliverables

## Description (10%)

Provide in a text file named `description.txt` a brief description of the service(s) you are planning to host.


## Infrastructure setup file (20%)

Provide a setup file that will create your environment named `setup.ps1`. 

It should create your main resources in a resource group named `ca1_rg`. 

Your setup file should be *idempotent* such that it will either:

- detect / ignore / repair partially built environments
- refuse to continue to run if the `ca1_rg` group is present

Although it's not mandatory you *can* use Azure resource manager templates to build your environment as long as they are instantiated from the setup file.
(If you do, obviously make sure that you include them in your submission!)


## Cloud init file (20%)

Provide a cloud init file named `vm_init.yml` for your VM.
You should aim to set up as much as possible in this file to minimise work in subsequent steps.


## VM setup (20%)

In a file `instructions.txt` provide a basic set of instructions for someone of the same skill level as you to work through the VM setup steps required, particularly any manual steps needed.
You can (and should) include any script(s) in your repository.


## Teardown file (10%)

Provide a teardown file named `teardown.ps1` that will remove your environment.
It is normally sufficient to delete the resource group involved.


## Use of version control (10%)

Marks in this section will be awarded for:

- Reasonable commit history, suggest at least 10 or more.
- Meaningful commit messages.
- Files not required ignored using `.gitignore` and not present in the repository.


# Checking for required files

A number of the steps above require you to submit specific files with specific names.

Depending on how you carried out some steps, you may have additional files required (e.g. a setup script calls another script or template).
Make sure that no file paths are absolute (e.g. `C:\Users\grantp\template.json`), and that all are relative.


# Submission

Your work should be presented in a Git repository named exactly `cloud_arch_ca1` (case sensitive) on the [school's GitLab server](https://gitlab.comp.dkit.ie/).
No submissions will be taken by e-mail, Moodle or other means.

To be accepted for grading, you must:

1. Name your repository exactly `cloud_arch_ca1`.
2. Add `grantp` with *Developer* access to your repository.

Repositories that are incorrectly named or that I cannot access will be treated as a non-submission and will receive a zero grade.
This will be strictly enforced.

You are therefore encouraged to set up your repository and give me access as soon as you start the CA.
There's no point leaving it until the last minute.
Once you have the repository set up and have added me you should as for it to be checked that I can see it.

The most recent commit in advance of the deadline will be graded. 


# Demonstration

You will be required to demonstrate your solution briefly during a lab session. 
The demonstration should include:

- Setup automatically including the creation of all resources.
- VM setup via cloud-init and perhaps afterwards (e.g. file transfer)
- System running
- Teardown

It is expected that you will be able to explain in professional terms how you achieved the system's functionality.


# Feedback

Group feedback will be provided in class.

Individual summary feedback will be provided on Moodle.
More detailed verbal feedback is available on request.

