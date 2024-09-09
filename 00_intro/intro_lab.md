% Cloud Architecture Introduction

**Lecturer:** Dr Peadar Grant

[Module descriptor](https://courses.dkit.ie/index.cfm/page/module/moduleId/56218/deliveryperiodid/1066)

# Learning outcomes

1. **MLO1:** Describe principle cloud computing concepts, service models and benefits.
2. **MLO2:** Assemble virtual cloud infrastructure on commercial cloud service providers incorporating identity and access management and other security considerations.
3. **MLO3:** Migrate backend application workloads from development and on-premises deployments to public, hybrid and private cloud infrastructure.
4. **MLO4:** Design cloud-first architectures to leverage managed database, cache, load balancing and storage services.
5. **MLO5:** Automate provisioning, deployment, scaling and monitoring operations.
6. **MLO6:** Evaluate the suitability of commercial cloud platforms for existing on-premises and new workloads.


# Module Indicative Content

## Cloud Fundamentals

Cloud computing definition; Outsourcing in the business and technology contexts; Public, private and hybrid cloud models. Understanding the cloud computing stack: IaaS, PaaS, SaaS, Storage as a Service. Comparison of cloud to on-premises deployments. Examine terms-of-service and SLAs offered by commercial cloud providers.

## Cloud Infrastructure

Assembly of infrastructure on commercial cloud providers incorporating compute, networking and storage as a service. Provisioning of compute capacity for multiple server operating systems. Evaluation of object, block and network file systems for storage workloads. Migration of existing web and other backend workloads to IaaS platforms. Setup of IP and DNS for reachability.

## Application design

Design of cloud-first applications designed for on-demand horizontal scaling. Selection of managed cloud platform services: databases (relational, non-relational, graph, full-text search), in-memory caches, messaging queues, notification services, directory services, edge caching, content delivery networks, managed DNS. Replication across multiple geographic regions for availability and performance optimisation.

## Cloud Migration

Evaluate current business applications and their suitability for migration and/or full/partial redesign for cloud deployment. Consideration of access management, security vulnerabilities, data availability, response time, backup, licensing. Design of partial and staged migrations that link on-premises and cloud workloads, incorporating VPN and dedicated links.

## Automation

Automation of provisioning and lifecycle management using provider tools and self-built automation scripting. Usage of infrastructure-as-code patterns to assemble cloud infrastructure and managed services. Automated scaling of component services to optimise identified performance and cost metrics.


# Assessment

There are **4** assessments in this module:

1. **Class test 1** (End semester 1, 20%)
2. **CA1** (Due end semester 1, 20%)
3. **Class test 2** (End semester 2, **40%**)
4. **CA2** (Due end semester 2, 20%)

**Important to remember:** This module is:

- **10 credits** so important to pass!
- **Year long**


# Content

All content will be placed in this git repository unless otherwise specified.

Make sure to run `git pull --rebase` regularly to update your copy of the files.

You *need* to use a local clone of the git repository.
You can browse the repository online on your phone / tablet directly from GitHub but running the code and viewing the notes pages in HTML require a local clone.


# Assumed prior knowledge

We will be *using* a lot of concepts that you've *already* studied in previous modules.
This will hopefully be familiar to you due to usage and repetition, but may need some revision on your part.
We will review and extend certain concepts again as necessary.

## Relevant modules

- **Cloud foundations**
- **Cloud technologies**

## Specific skills

You should have: 

- Familiarity with command-line interfaces (built by regular routine usage of them!)
- Basic Bash usage on Linux:
  - Concept of working directory
  - Navigating filesystem using `pwd`, `cd` and relative operators, e.g. `..`, `/` etc.
  - Manipulating files using `rm`, `mv`, `cp` etc.
  - Displaying files using `cat`, `more` etc.
  - Manipulating directories using `mkdir`, `rmdir` etc.
  - File permissions and ownership `chmod`, `chown` etc.
  - Use of wildcards (e.g. `*`) to refer to multiple files.
  - Up cursor to recall previous commands
- Basic PowerShell usage on Windows
  - Same ideas as above for Bash required.
- You can run an existing Python or PowerShell program in the command-line environment.
- Accessing help on commands via switches (e.g. `-h` or similar) and using `man` command. 
- Principle of Shell redirection (`>`, `<`) and command piping / chaining (`|`)
  - Using `Get-Content` and `Out-File` in PowerShell to achieve same aims.
- JSON format
  - Basic understanding of JSON structure manually
  - Encountered JSON in files, from command output and APIs.
  - Using `ConvertFrom-Json` and `ConvertTo-Json` in PowerShell
- Secure SHell (`ssh`)
  - Idea of accessing remote command-line shells on another host
  - Key-based authentication using public/private keypair 
  - More advanced concepts: single-command, agent forwarding etc.
- SFTP (`sftp`)
  - standard operations (`get`, `put`)
  - concept of local/remote directory navigation (`cd`, `lcd`, etc)
- Plain text editors via local GUI (e.g. notepad, emacs, VSCode) and local/remote console (`emacs`, `nano`, `vim` etc).
- Working knowledge of `git` (e.g. `git pull --rebase`)
- AWS
  - AWS Console and CLI
  - Main IaaS and PaaS components
  - VPC incl. subnets, gateways, routing, security groups
  - EC2 incl. operating systems, user data scripts, SSH connection, Windows password discovery
  - PaaS services including S3, SQS, SNS, Lambda
  - Basic AWS IAM role and policy setup
- Basic CloudFormation knowledge
  - Templates, stacks
  - Creating / updating / deleting stacks in GUI and CLI
  - Parameters and Outputs in templates for customisation and inspection
  - Combining CloudFormation with PowerShell

## Command-line interfaces

If you *"don't do" command line interfaces* you will need to reset that starting limitation you've placed on yourself for success in this module.
Almost **all** of our work **will** involve command-line interfaces with no GUI alternative.
There's simply no way of avoiding CLIs here!

# Client system requirements

The only supported client configuration is the DkIT specialist lab computers.
All required client software is installed on DkIT specialist lab computers (P1153).
In additional all required services are accessible from DkIT specialist lab computers.

You are welcome to try using your own device(s) at home and within DkIT, as well as non-specialist-lab computers to help you in this module.
While I encourage you to try things out, you are responsible for supporting your own devices and configurations.

The `client_check.ps1` and `client_check.sh` scripts (which call the `system_check.py` script) can be used to see if all required software for this module is installed on the client device you'll use for the module.


# Remote access

**TODO:** confirm remote access arrangments based on new network setup 2024


# Academic integrity

You are reminded that all of your work must comply with DkIT Academic Integrity Policy.

Specific guidance will be given on the assessments in this module.

