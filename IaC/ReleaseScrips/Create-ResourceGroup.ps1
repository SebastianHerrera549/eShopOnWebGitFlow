<#
 .SYNOPSIS
    Create the Infrastructure for the ShopWebLyL Project

 .DESCRIPTION
    1. Create the Resource Group
    2. Create the Application SErvice Plan
    3. Create the Web Application

  .PARAMETER ResourceGroupName
    Application Name

 .PARAMETER Location
    Location for the Resources
 #>
param (
   [Parameter(Mandatory = $true)]
   [string] $ResourceGroupName,

   [parameter(Mandatory = $true)]
   [string] $Location
)
<################
#-- Functions --#
################>
function Create-ResourceGroup ([string]$resourceGroupName, [string]$location) {
   # Create the Resource Group
   Write-Host "Creating The Resource Group: $resourceGroupName" -ForegroundColor Cyan
   New-AzResourceGroup -Name $resourceGroupName -Location $location -Force -ErrorAction Stop | Out-Host
}


<#################
#--    Main    --#
#################>

# Record Start Time
$ScriptStartTime = $(Get-Date)
Write-Host "Script started at:"$ScriptStartTime -ForegroundColor Yellow

# Create the Resource Gruop
Create-ResourceGroup -resourceGroupName $resourceGroupName -Location $Location

# Record End time and Duration
$ScriptEndTime = $(Get-Date)
$ScriptDuration = $ScriptEndTime - $ScriptStartTime
Write-Host "Script ended at:" $ScriptEndTime -ForegroundColor Yellow
Write-Host "Total time: $ScriptDuration" -ForegroundColor Blue