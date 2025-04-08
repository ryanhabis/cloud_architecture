% Cloud architecture CA2

**Weight:** 20%

**Deadline:** 02/05/2025 21:00


# Summary

You are to construct a CI/CD pipeline-driven deployment of an application to the Azure platform.

You may use a Java, .net or other application that you've written yourself.
You may also use a Java, .net or other application that you can programmatically retrieve from the internet.
You may not however use the `TrainTimes` example from class directly.
This example however has some valuable pointers on how you can do this. 

The OS (or combination thereof) on VMs is entirely up to you.

For ease of organisation and grading, the application to be deployed and the additional scripts for setup / teardown will be contained in one single git repository.


# Deliverables

*Required deliverables can only receive a grade if the relevant file is provided.*

## Description (10%)

Provide in a text file named `description.txt` a brief description of the applications(s) you are planning to deploy.


## Cloud infrastructure setup (20%)

Provide a `./setup.ps1` that will set up all required Azure services in a resource group named `ca2_rg` (not `lab_rg`).

This file should be commented to explain the *reasons* behind actions you take where needed (e.g. why is a rule needed on a network security group, or why has a larger than normal machine size been selected).


## Build host setup (20%)

Use `cloud-init` to configure as much as possible on the build host as you can. The cloud config custom data file should be provided in `build_host_config.yml`.

Your cloud config file **must** write a file to the default home user's home directory indicating that it has completed. 
(See examples from class.)


## GitLab runner setup (10%)

You should provide evidence in the form of a copy of the terminal output showing that the runner has been setup in `runner_installed.txt`.

You should also provide evidence in the form of a screenshot that the runner has been linked to your GitLab repository in `runner_linked.png`. 


## CI pipeline (20%)

Your pipeline in `.gitlab-ci.yml` must at the very least build / deploy the main project as described in the first section (description).

It can do this by itself or in conjunction with tools like `mvn` or `msbuild`.

To maximise marks:

- Use the fetch (rather than clone) strategy.
- Turn on caching to reduce network bandwidth.
- Selectively return artefacts back to the GitLab server.


## Deployment evidence (20%)

Evidence of your deployment functioning by 3x screenshots named `screenshot1.png`, `screenshot2.png` and `screenshot3.png`.


# Checking for required files

A number of the steps above require you to submit specific files with specific names.

Depending on how you carried out some steps, you may have additional files required (e.g. a setup script calls another script or template).
Make sure that no file paths are absolute (e.g. `C:\Users\grantp\template.json`), and that all are relative.



# Submission

Your work should be presented in a Git repository named exactly `cloud_arch_ca2` (case sensitive) on the [school's GitLab server](https://gitlab.comp.dkit.ie/).
No submissions will be taken by e-mail, Moodle or other means.

To be accepted for grading, you must:

1. Name your repository exactly `cloud_arch_ca2`.
2. Add `grantp` with *Developer* access to your repository.

Repositories that are incorrectly named or that I cannot access will be treated as a non-submission and will receive a zero grade.
This will be strictly enforced.

You are therefore encouraged to set up your repository and give me access as soon as you start the CA.
There's no point leaving it until the last minute.
Once you have the repository set up and have added me you should as for it to be checked that I can see it.

The most recent commit in advance of the deadline will be graded. 


# Feedback

Group feedback will be provided in class.

Individual summary feedback will be provided on Moodle.
More detailed verbal feedback is available on request.

