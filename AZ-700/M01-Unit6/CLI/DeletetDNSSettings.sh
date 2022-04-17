#!/bin/bash
#Deletes the resource group created in CreatVirtualNetwork.sh
#This will also delete all the resources within the resource group

# Delete resource group
az group delete --name ContosoResourceGroup --yes


