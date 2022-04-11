#!/bin/bash


# Create resource group
az group create --name ContosoResourceGroup --location eastus


# Create virtual networks

az network vnet create --name CoreServicesVnet  --resource-group ContosoResourceGroup --location eastus --address-prefix 10.20.0.0/16
az network vnet create --name ManufacturingVnet --resource-group ContosoResourceGroup  --location westeurope  --address-prefix 10.30.0.0/16
az network vnet create --name ResearchVnet --resource-group ContosoResourceGroup  --location southeastasia --address-prefix 10.40.0.0/16

# Create Subnets
az network vnet subnet create  --name GatewaySubnet --resource-group ContosoResourceGroup  --vnet-name CoreServicesVnet --address-prefixes 10.20.0.0/27
az network vnet subnet create  --name SharedServicesSubnet --resource-group ContosoResourceGroup  --vnet-name CoreServicesVnet --address-prefixes 10.20.10.0/24
az network vnet subnet create  --name DatabaseSubnet --resource-group ContosoResourceGroup --vnet-name CoreServicesVnet --address-prefixes 10.20.20.0/24
az network vnet subnet create  --name PublicWebServiceSubnet --resource-group ContosoResourceGroup --vnet-name CoreServicesVnet --address-prefixes 10.20.30.0/24
###############################################################
az network vnet subnet create  --name ManufacturingSystemSubnet --resource-group ContosoResourceGroup --vnet-name ManufacturingVnet --address-prefixes  10.30.10.0/24
az network vnet subnet create  --name SensorSubnet1 --resource-group ContosoResourceGroup --vnet-name ManufacturingVnet --address-prefixes 10.30.20.0/24
az network vnet subnet create  --name SensorSubnet2 --resource-group ContosoResourceGroup --vnet-name ManufacturingVnet --address-prefixes 10.30.21.0/24
az network vnet subnet create  --name SensorSubnet3 --resource-group ContosoResourceGroup --vnet-name ManufacturingVnet --address-prefixes 10.30.22.0/24
###############################################################
az network vnet subnet create  --name ResearchSystemSubnet --resource-group ContosoResourceGroup --vnet-name ResearchVnet --address-prefixes 10.40.0.0/24

