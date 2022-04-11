#Deletes the resource group created in CreatVirtualNetwork.ps1
#This will also delete all the resources within the resource groups

# Delete resource group
Remove-AzResourceGroup -Name "ContosoResourceGroup" -Force



