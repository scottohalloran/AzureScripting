#!/bin/bash


#Create the VNet gateways

az network vnet-gateway create 
--name CoreServicesVnetGateway 
--location eastus 
--resource-group ContosoResourceGroup 
--vnet 
--gateway-type vpn 
--sku VpnGw1 
--vpn-type RouteBased 
--vpn-gateway-generation Generation1
az network vnet peering create --name ManufacturingVnet-to-CoreServicesVnet --remote-vnet CoreServicesVnet --resource-group ContosoResourceGroup --vnet-name ManufacturingVnet