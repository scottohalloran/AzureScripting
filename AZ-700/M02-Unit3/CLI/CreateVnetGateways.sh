#!/bin/bash


#Create the public IPs for the VNet gateways
az network public-ip create --name CoreServicesVnetGateway-ip --resource-group ContosoResourceGroup --location eastus 
az network public-ip create --name ManufacturingVnetGateway-ip --resource-group ContosoResourceGroup --location westeurope

#Create the VNet gateways
az network vnet-gateway create \
--resource-group ContosoResourceGroup \
--name CoreServicesVnetGateway \
--location eastus \
--gateway-type vpn \
--vpn-type RouteBased \
--sku VpnGw1 \
--vpn-gateway-generation Generation1 \
--vnet CoreServicesVnet \
--public-ip-addresses CoreServicesVnetGateway-ip \

az network vnet-gateway create \
--resource-group ContosoResourceGroup \
--name ManufacturingVnetGateway \
--location westeurope \
--gateway-type vpn \
--vpn-type RouteBased \
--sku VpnGw1 \
--vpn-gateway-generation Generation1 \
--vnet ManufacturingVnet \
--public-ip-addresses ManufacturingVnetGateway-ip \




