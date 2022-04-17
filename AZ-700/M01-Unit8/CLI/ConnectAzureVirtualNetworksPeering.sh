#!/bin/bash


# Create resource group
az group create --name ContosoResourceGroup --location eastus

# Create virtual networks

az network vnet create --name CoreServicesVnet  --resource-group ContosoResourceGroup --location eastus --address-prefix 10.20.0.0/16
az network vnet create --name ManufacturingVnet --resource-group ContosoResourceGroup  --location eastus  --address-prefix 10.30.0.0/16
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

#Create vitual machines to test the configurationconnections

#Create the network security group for the test VMs
az network nsg create --name testvm1-nsg --resource-group ContosoResourceGroup 
az network nsg create --name NanufacturingVM-nsg --resource-group ContosoResourceGroup 

#Create the public IPs for the test VMs
az network public-ip create --name PIPName1 --resource-group ContosoResourceGroup --location eastus 
az network public-ip create --name ManufacturingVM-ip --resource-group ContosoResourceGroup --location eastus 


#Create the NICs for the VMs
az network nic create --name testvm1-nic --network-security-group testvm1-nsg --public-ip-address PIPName1 --resource-group ContosoResourceGroup --subnet DatabaseSubnet --vnet-name CoreServicesVnet 
az network nic create --name ManufacturingVM-nic --network-security-group NanufacturingVM-nsg --public-ip-address ManufacturingVM-ip --resource-group ContosoResourceGroup --subnet ManufacturingSystemSubnet --vnet-name ManufacturingVnet

#Create the VM
az vm create --admin-username TestUser --admin-password TestPa$$w0rd! --image Win2019Datacenter --name testvm1 --public-ip-sku Basic --resource-group ContosoResourceGroup --nics testvm1-nic --size Standard_DS1_v2
az vm create --admin-username TestUser --admin-password TestPa$$w0rd! --image Win2019Datacenter --name ManufacturingVM --public-ip-sku Basic --resource-group ContosoResourceGroup --nics ManufacturingVM-nic --size Standard_DS1_v2

#Open port 3389
az vm open-port --port 3389 --resource-group ContosoResourceGroup --name testvm1
az vm open-port --port 3389 --resource-group ContosoResourceGroup --name ManufacturingVM
