# Comprehensive Summary: Control Network Traffic Flow with Routes

## Module 1: Introduction to Control Traffic Flow & Routing
- **Overview**: Understanding how Azure manages network traffic by default and how administrators can override standard behaviors to enforce security policies and traffic paths.
- **Core Routing Mechanisms**:
  - **System Routes**: Automatically created by Azure for every subnet, defining default intra-VNet, inter-VNet, and internet routing paths.
  - **User-Defined Routes (UDRs)**: Custom routes created by administrators to override system routes and direct traffic to specific next-hop targets.
  - **Network Virtual Appliances (NVAs)**: Virtual machines acting as routers, firewalls, or WAN optimizers to inspect and control traffic flow.

---

## Module 2: Azure Virtual Network Route & System Routes
- **Default System Route Behavior**: All subnets within a virtual network can communicate with each other by default without any configuration.
- **Next-Hop Types**:
  - **Virtual Network**: Direct routing within the same VNet or peered VNets.
  - **Internet**: Default route (`0.0.0.0/0`) pointing directly to the Azure public backbone.
  - **Virtual Appliance / Virtual Network Gateway**: Custom routing targets for traffic interception.
- **Role of Route Tables**: Route tables contain one or more routes and are explicitly associated with one or more subnets.

---

## Module 3: Exercise: Create Custom Routes
- **Practical Implementation**: Building custom route tables and associating them with specific subnets (e.g., public vs. private subnets).
- **Core Workflow**:
  - Create a Route Table (`az network route-table create`).
  - Add a custom route specifying the destination prefix and next-hop IP address (`az network route-table route create`).
  - Associate the route table with the target subnet (`az network vnet subnet update`).
- **Validation**: Verifying that traffic is successfully redirected or intercepted according to the newly applied route rules.

---

## Module 4: Network Virtual Appliances (NVAs)
- **Architectural Role**: NVAs provide advanced security inspection, threat protection, and traffic shaping in cloud topologies.
- **Perimeter Networks (DMZ)**: Placing an NVA in a dedicated subnet to act as a gateway for incoming, outgoing, and cross-subnet traffic.
- **Key Configuration Requirements**:
  - **IP Forwarding**: Must be explicitly enabled on the NVA's network interface (NIC) so it accepts and forwards packets destined for other IP addresses.
  - **OS-Level Routing**: The operating system inside the NVA (such as Ubuntu or a commercial firewall OS) must be configured to route IP packets.

---

## Module 5: Exercise: Create NVA VM
- **Deployment Strategy**: Provisioning an Ubuntu virtual machine in a DMZ or gateway subnet to function as a custom router.
- **Core Configuration Steps**:
  - Deploying the VM instance with appropriate network interfaces.
  - Enabling IP forwarding on the Azure NIC (`az network nic update --ip-forwarding true`).
  - Configuring administrative access and basic packet forwarding rules on the guest OS.

---

## Module 6: Exercise: Route Traffic Through NVA
- **Traffic Interception Setup**:
  - Creating a custom route table where traffic destined for private subnets or the internet (`0.0.0.0/0`) has its next-hop set to the NVA's private IP address.
  - Disabling BGP route propagation if necessary to prevent dynamic routes from overriding custom UDRs.
- **End-to-End Testing**:
  - Validating that packets originating from a public or client subnet traverse the NVA before reaching the private backend subnet.
  - Using network diagnostic tools (`Test-NetConnection`, `traceroute`, or `tcpdump`) to confirm the NVA is actively processing the traffic flow.

---

## Module 7: Summary and Best Practices
- **Key Takeaways**:
  - Custom routes and UDRs give administrators granular control over enterprise network topologies.
  - NVAs are essential for implementing secure hybrid architectures and inspecting traffic between isolated zones.
- **Operational Cleanup**: Reminder to delete lab resource groups and virtual machines to prevent unnecessary resource consumption and subscription charges.


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
