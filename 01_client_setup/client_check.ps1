#!/usr/bin/env pwsh
# Client check launcher script for Automation Module
# Peadar Grant

# check if Python is installed on the system
try {
    $pythons = ( get-command -all python )
    Write-Host "python is installed on this computer"
}
catch {
    Write-Host "install Python on this computer to continue and try again"
    exit
}

# if so, then run the common client check script
python ./system_check.py --wrapper windows
