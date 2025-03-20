#!/bin/bash
# Install gitlab runner
# (Original by Andrew Shaw)

# Download the gitlab repo addition script and pipe to bash to run
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash

# run the installation program
sudo apt-get install gitlab-runner



