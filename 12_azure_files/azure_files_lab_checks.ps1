#!/usr/bin/env pwsh
# Azure files lab checks
# Peadar Grant

if ( -not ( Get-Command az ) ) {
    throw "az command does not exist"
}


