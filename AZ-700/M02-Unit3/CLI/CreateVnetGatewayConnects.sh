#!/bin/bash



#Create the VNet gateway connections
az network vpn-gateway connection create \
--resource-group ContosoResourceGroup \
--gateway-name CoreServicesVnetGateway \
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




