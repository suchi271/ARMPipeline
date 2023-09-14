Connect-AzAccount

# Define variables
$resourceGroupName = "ResourceDeployment"
$storageAccountName = "suchistorageaccount"

# Deploy the Azure Storage Account using ARM template and parameters
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile create_storage_account/azuredeploy.json

#print after deployment
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
Write-Host "Storage Account Name: $($storageAccount.StorageAccountName)"
