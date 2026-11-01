## 🚀 Practical Exercise Workflow & Commands

## Setup & Environment Configuration

**0. Ensure Bicep CLI is up to date:**

```bash
az bicep install && az bicep upgrade
```

**1. Sign in to Azure:**

```powershell
az login
```

**2. Create resource group:**

```powershell
az group create --name rg-bicep --location swedencentral
```

**3. Create a route table:**

```powershell
az network route-table create --name publictable --resource-group rg-bicep --disable-bgp-route-propagation false
```

**4. Create a custom route:**

```powershell
az network route-table route create --route-table-name publictable --resource-group rg-bicep --name productionsubnet --address-prefix 10.0.1.0/24 --next-hop-type VirtualAppliance --next-hop-ip-address 10.0.2.4
```

**5. Create a virtual network and subnets:**

```powershell
az network vnet create --name vnet --resource-group rg-bicep --address-prefixes 10.0.0.0/16 --subnet-name publicsubnet --subnet-prefixes 10.0.0.0/24
```

```powershell
az network vnet subnet create --name privatesubnet --vnet-name vnet --resource-group rg-bicep --address-prefixes 10.0.1.0/24
```

```powershell
az network vnet subnet create --name dmzsubnet --vnet-name vnet --resource-group rg-bicep --address-prefixes 10.0.2.0/24
```

```powershell
az network vnet subnet list --resource-group rg-bicep --vnet-name vnet --output table
```

**6. Associate the route table with the public subnet:**

```powershell
az network vnet subnet update --name publicsubnet --vnet-name vnet --resource-group rg-bicep --route-table publictable
```

**7. Deploy the network virtual appliance:**

```powershell
az vm create --resource-group rg-bicep --name nva --vnet-name vnet --subnet dmzsubnet --image Ubuntu2204 --size Standard_B1s --admin-username azureuser --admin-password Test1234tesT
```

**8. Enable IP Forwarding on network interface:**

```powershell
$NICID = (az vm nic list --resource-group rg-bicep --vm-name nva --query "[].{id:id}" --output tsv)
echo $NICID
```

```powershell
$NICNAME=(az vm nic show --resource-group rg-bicep --vm-name nva --nic $NICID --query "{name:name}" --output tsv)
echo $NICNAME
```

```powershell
az network nic update --name $NICNAME --resource-group rg-bicep --ip-forwarding true
```

**9. Enable IP forwarding in the appliance:**

```powershell
$NVAIP=(az vm list-ip-addresses --resource-group rg-bicep --name nva --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" --output tsv)
echo $NVAIP
```

```powershell
ssh -t -o StrictHostKeyChecking=no azureuser@$NVAIP 'sudo sysctl -w net.ipv4.ip_forward=1; exit;'
```

**10. Create public and private virtual machines:**

```powershell
[System.IO.File]::WriteAllText("$PWD\cloud-init.txt", "#cloud-config`npackage_upgrade: true`npackages:`n  - inetutils-traceroute", [System.Text.UTF8Encoding]::new($false))
```

```powershell
az vm create --resource-group rg-bicep --name public --vnet-name vnet --subnet publicsubnet --image Ubuntu2204 --admin-username azureuser --no-wait --custom-data cloud-init.txt --admin-password Test1234tesT
```

```powershell
az vm create --resource-group rg-bicep --name private --vnet-name vnet --subnet privatesubnet --image Ubuntu2204 --admin-username azureuser --no-wait --custom-data cloud-init.txt --admin-password Test1234tesT
```

```powershell
watch -d -n 5 "az vm list --resource-group rg-bicep --show-details --query '[*].{Name:name, ProvisioningState:provisioningState, PowerState:powerState}' --output table"
```

```powershell
$PUBLICIP=(az vm list-ip-addresses --resource-group rg-bicep --name public --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" --output tsv)
echo $PUBLICIP
```

```powershell
$PRIVATEIP=(az vm list-ip-addresses --resource-group rg-bicep --name private --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" --output tsv)
echo $PRIVATEIP
```

**11. Test traffic routing through the network virtual appliance:**

```powershell
ssh -t -o StrictHostKeyChecking=no azureuser@$PUBLICIP 'traceroute private --type=icmp; exit'
```

```powershell
ssh -t -o StrictHostKeyChecking=no azureuser@$PRIVATEIP 'traceroute public --type=icmp; exit'
```

**12. Cleanup: Deleting the Resource Group (rg-bicep):**

```powershell
az group delete --name rg-bicep --yes --no-wait
```
