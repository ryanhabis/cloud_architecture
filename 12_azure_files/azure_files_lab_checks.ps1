#!/usr/bin/env pwsh
# Azure files lab checks
# Peadar Grant

# check that the az command exists
if ( -not ( Get-Command az ) ) {
    throw "az command does not exist"
}



