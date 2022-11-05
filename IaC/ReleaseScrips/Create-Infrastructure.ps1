<#
 .SYNOPSIS
    Create the Infrastructure for the Project

 .DESCRIPTION
    1. Create the Resource Group
    2. Create the Application SErvice Plan
    3. Create the Web Application

  .PARAMETER ApplicationName
    Application Name (ShopWeb)

 .PARAMETER Location
    Location for the Resources (EastUS, WestUS, CentralUS)
 #>
param (
    [Parameter(Mandatory = $true)]
    [string] $ApplicationName,

    [parameter(Mandatory = $true)]
    [string] $Location
)
#################
#-- Functions --#
#################
function Create-ResourceGroup ([string]$resourceGroupName, [string]$location) {
    # Create the Resource Group
    Write-Host "Creating The Resource Group: $resourceGroupName" 
    New-AzResourceGroup -Name $resourceGroupName -Location $location -ErrorAction Stop | Out-Host
}

function Create-AppServicePlan([string]$appServicePlan, [string]$resourceGroupName, [string]$location) {
    # Create an App Service plan in Free tier.  
    Write-Host "Creating The App Service Plan: $appServicePlan" 
    New-AzAppServicePlan -Name $appServicePlan -Location $location -ResourceGroupName $resourceGroupName -Tier Free -ErrorAction Stop | Out-Host
}

function Create-WebApp([string]$webappname, [string]$appServicePlan, [string]$resourceGroupName, [string]$location) {
    # Create a web app.   
    Write-Host "Creating The Web App: $webappname" 
    New-AzWebApp -Name $webappname -Location $location -AppServicePlan $AppServicePlan -ResourceGroupName $resourceGroupName -ErrorAction Stop | Out-Host
}

function Set-AppSettingToWebApp([string]$webappname, [string]$resourceGroupName) {
    # Set the AppSetting to the web app.   
    Write-Host "Set the AppSetting to The Web App: $webappname" 
    
    # Bind the Current Web App
    $webApp = Get-AzureRmWebApp -ResourceGroupName $resourceGroupName -Name $webAppName    
    
    # Get the Current AppSetting
    $appSettings = $webapp.SiteConfig.AppSettings
    
    # Create the New AppSetting
    $newAppSettings = @{}
    
    # Copy the Current AppSetting to the newones
    ForEach ($item in $appSettings) {
        $newAppSettings[$item.Name] = $item.Value
    }

    # Add the New Values
    $newAppSettings[‘ASPNETCORE_ENVIRONMENT’] = “Development”
    
    # OverRide the AppSettings to the WebApp
    Set-AzureRmWebApp -AppSettings $newAppSettings -Name $webAppName -ResourceGroupName $resourceGroupName
}



##################
#--    Main    --#
##################

# Record Start Time
$ScriptStartTime = $(Get-Date)
Write-Host "Script started at:"$ScriptStartTime -ForegroundColor Yellow

# Build Resource Group Name
$resourceGroupName = "{0}-RG" -f $applicationName
# Build the application Plan Name
$appServicePlan = "{0}-Plan" -f $applicationName
# Build Web Application Name
$webappname = "{0}Site" -f $applicationName

# Create the Resource Gruop
Create-ResourceGroup -resourceGroupName $resourceGroupName -Location $Location

# Create the App Service Plan
Create-AppServicePlan -appServicePlan $appServicePlan -resourceGroupName $resourceGroupName -Location $Location

# Create a web app.   
Create-WebApp -webappname $webappname -appServicePlan $appServicePlan -resourceGroupName $resourceGroupName -Location $Location

# Set the AppSettings
Set-AppSettingToWebApp -webappname $webappname -resourceGroupName $resourceGroupName


# Record End time and Duration
$ScriptEndTime = $(Get-Date)
$ScriptDuration = $ScriptEndTime - $ScriptStartTime
Write-Host "Script ended at:" $ScriptEndTime -ForegroundColor Yellow
Write-Host "Total time: $ScriptDuration" -ForegroundColor Blue