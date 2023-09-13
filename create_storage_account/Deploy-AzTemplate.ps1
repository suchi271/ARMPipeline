Connect-AzAccount

# Define variables
$resourceGroupName = "ResourceDeployment"
$storageAccountName = "azureStorageAccount"
$location = "Central India" 
$storageAccountSku = "Standard_LRS" 

# Deploy the Azure Storage Account using ARM template and parameters
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
    -TemplateFile .\azuredeploy.json `
    -TemplateParameterFile .\azuredeploy.parameters.json `
    -storageAccountName $storageAccountName `
    -location $location `
    -storageAccountSku $storageAccountSku

# Check deployment status
$deployment = Get-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name (Get-Date -UFormat "%Y%m%d%H%M%S")

if ($deployment.ProvisioningState -eq "Succeeded") {
    Write-Host "Azure Storage Account deployment succeeded."
    $storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
    Write-Host "Storage Account Name: $($storageAccount.StorageAccountName)"
    Write-Host "Storage Account Key1: $($storageAccount.Keys[0].Value)"
} else {
    Write-Host "Azure Storage Account deployment failed."
    Write-Host "Details: $($deployment.StatusMessage)"
}
