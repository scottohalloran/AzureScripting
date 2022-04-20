#!/bin/bash


# Create resource group
az group create --name ContosoResourceGroup --location eastus

# Create the private DNS zone
az network private-dns zone create --resource-group ContosoResourceGroup  --name contoso.com


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



#Create the virtual network links
az network private-dns link vnet create --resource-group ContosoResourceGroup  --name CoreServicesVnetLink --zone contoso.com --virtual-network CoreServicesVnet --registration-enabled True
az network private-dns link vnet create --resource-group ContosoResourceGroup  --name ManufacturingVnetLink --zone contoso.com --virtual-network ManufacturingVnet --registration-enabled True
az network private-dns link vnet create --resource-group ContosoResourceGroup  --name ResearchVnetLink --zone contoso.com --virtual-network ResearchVnet --registration-enabled True


#Create vitual machines to test the configuration

#Create the network security groups for the test VMs
az network nsg create --name testvm1-nsg --resource-group ContosoResourceGroup 
az network nsg create --name testvm2-nsg --resource-group ContosoResourceGroup 

#Create the public IPs for the test VMs
az network public-ip create --name PIPName1 --resource-group ContosoResourceGroup --location eastus 
az network public-ip create --name PIPName2 --resource-group ContosoResourceGroup --location eastus 

#Create the NICs for the VMs
az network nic create --name testvm1-nic --network-security-group testvm1-nsg --public-ip-address PIPName1 --resource-group ContosoResourceGroup --subnet DatabaseSubnet --vnet-name CoreServicesVnet 
az network nic create --name testvm2-nic --network-security-group testvm2-nsg --public-ip-address PIPName2 --resource-group ContosoResourceGroup --subnet DatabaseSubnet --vnet-name CoreServicesVnet 

#Create the VMs
az vm create --admin-username TestUser --admin-password 'TestPa$$w0rd!' --image Win2019Datacenter --name testvm1 --public-ip-sku Basic --resource-group ContosoResourceGroup --nics testvm1-nic 
az vm create --admin-username TestUser --admin-password 'TestPa$$w0rd!' --image Win2019Datacenter --name testvm2 --public-ip-sku Basic --resource-group ContosoResourceGroup --nics testvm2-nic 
