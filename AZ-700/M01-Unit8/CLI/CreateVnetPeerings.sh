#!/bin/bash


#Create the VNet peerings
az network vnet peering create --name CoreServicesVnet-to-ManufacturingVnet --remote-vnet ManufacturingVnet --resource-group ContosoResourceGroup --vnet-name CoreServicesVnet
az network vnet peering create --name ManufacturingVnet-to-CoreServicesVnet --remote-vnet CoreServicesVnet --resource-group ContosoResourceGroup --vnet-name ManufacturingVnet