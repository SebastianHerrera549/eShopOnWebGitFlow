<#
 .SYNOPSIS
    remove the Infrastructure for the ShopWebLyL Project

 .DESCRIPTION
    1. Remove the Resource Group

 .PARAMETER ApplicationName
    Application Name

 #>
param (
    [Parameter(Mandatory = $true)]
    [string] $ApplicationName
)
<################
#-- Functions --#
################>
function Remove-ResourceGroup ([string]$resourceGroupName, [string]$location) {
    # Create the Resource Group
    Write-Host "Removing The Resource Group: $resourceGroupName" 
    Remove-AzResourceGroup -Name $resourceGroupName -Verbose -Force -ErrorAction Stop | Out-Host
}

<#################
#--    Main    --#
#################>

# Record Start Time
$ScriptStartTime = $(Get-Date)
Write-Host "Script started at:"$ScriptStartTime -ForegroundColor Yellow

# Build Resource Group Name
$resourceGroupName = "$applicationName-RG"

# Create the Resource Gruop
Remove-ResourceGroup -resourceGroupName $resourceGroupName 

# Record End time and Duration
$ScriptEndTime = $(Get-Date)
$ScriptDuration = $ScriptEndTime - $ScriptStartTime
Write-Host "Script ended at:" $ScriptEndTime -ForegroundColor Yellow
Write-Host "Total time: $ScriptDuration" -ForegroundColor Blue