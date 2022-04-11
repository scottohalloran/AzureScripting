# Create resource groups
New-AzResourceGroup -Name "CoreServicesRG" -Location "westus"
New-AzResourceGroup -Name "ManufacturingRG" -Location "northeurope"
New-AzResourceGroup -Name "ResearchRG" -Location "westindia"



# Create Subnets
$gateway_subnet =  New-AzVirtualNetworkSubnetConfig -Name GatewaySubnet  -AddressPrefix 10.20.0.0/27
$shared_services_subnet = New-AzVirtualNetworkSubnetConfig -Name SharedServicesSubnet -AddressPrefix 10.20.10.0/24
$database_subnet = New-AzVirtualNetworkSubnetConfig -Name DatabaseSubnet  -AddressPrefix 10.20.20.0/24
$public_web_service_subnet = New-AzVirtualNetworkSubnetConfig -Name PublicWebServiceSubnet   -AddressPrefix 10.20.30.0/24
###############################################################
$manufacturing_system_subnet = New-AzVirtualNetworkSubnetConfig -Name ManufacturingSystemSubnet -AddressPrefix  10.30.10.0/24
$sensor_subnet_1 = New-AzVirtualNetworkSubnetConfig -Name SensorSubnet1  -AddressPrefix 10.30.20.0/24
$sensor_subnet_2 = New-AzVirtualNetworkSubnetConfig -Name SensorSubnet2  -AddressPrefix 10.30.21.0/24
$sensor_subnet_3 = New-AzVirtualNetworkSubnetConfig -Name SensorSubnet3  -AddressPrefix 10.30.22.0/24
###############################################################
$research_system_subnet = New-AzVirtualNetworkSubnetConfig -Name ResearchSystemSubnet -AddressPrefix 10.40.0.0/24
###############################################################


# Create virtual networks

New-AzVirtualNetwork -Name "CoreServicesVnet"  -ResourceGroupName "CoreServicesRG" -Location "westus" -AddressPrefix "10.20.0.0/16" -subnet $gateway_subnet,$shared_services_subnet,$public_web_service_subnet
New-AzVirtualNetwork -Name "ManufacturingVnet" -ResourceGroupName "ManufacturingRG"  -Location "northeurope" -AddressPrefix "10.30.0.0/16" -Subnet $manufacturing_system_subnet,$sensor_subnet_1,$sensor_subnet_2,$sensor_subnet_3
New-AzVirtualNetwork -Name  "ResearchVnet" -ResourceGroupName "ResearchRG" -Location "westindia" -AddressPrefix "10.40.0.0/16" -Subnet $research_system_subnet
