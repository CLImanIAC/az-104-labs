
# Comprehensive Summary: Configure Virtual Network Peering & Inter-site Connectivity

## Module 1: Introduction to Virtual Network Peering
- **Overview**: Virtual network (VNet) peering enables you to seamlessly connect two or more virtual networks in Azure.
- **Key Characteristics**: 
  - Peered VNets appear as a single network for connectivity purposes.
  - Traffic between virtual machines (VMs) in peered VNets uses the private Microsoft backbone network.
  - Traffic is kept entirely private and does not traverse the public internet.
- **Benefits**: Low-latency, high-bandwidth connections between resources across different virtual networks.

---

## Module 2: Determine Uses and Requirements for VNet Peering
- **Types of Peering**:
  - **Local VNet Peering**: Connects virtual networks within the same Azure region.
  - **Global VNet Peering**: Connects virtual networks across different Azure regions.
- **Use Cases**:
  - Multi-tier applications spanning separate VNets.
  - Cross-departmental architectures requiring isolated administration but shared communication.
- **Constraints & Requirements**:
  - Address spaces of the peered VNets must not overlap.
  - Changes to VNet address spaces require synchronization of the peering links.
  - No single point of failure introduced by peering itself; resources maintain their own security boundaries (such as Network Security Groups - NSGs).

---

## Module 3: Determine Gateway Transit and Connectivity
- **Gateway Transit Concept**: Allows a peered virtual network to use the VPN gateway or ExpressRoute gateway in a hub virtual network.
- **Hub-and-Spoke Architecture**:
  - **Hub VNet**: Centralized management point hosting shared services, firewalls, and gateways.
  - **Spoke VNets**: Workload-specific virtual networks peered to the hub.
- **Key Peering Settings for Transit**:
  - *Allow gateway transit*: Enabled on the hub peering so the spoke can use the hub's gateway.
  - *Use remote gateways*: Enabled on the spoke peering to leverage the hub's gateway infrastructure.

---

## Module 4: Create Virtual Network Peerings
- **Prerequisites**: Appropriate permissions (Network Contributor role or equivalent) on both virtual networks.
- **Bidirectional Requirement**: Peering must be established in both directions (VNet A to VNet B, and VNet B to VNet A) for full connectivity.
- **Peering States**:
  - **Initiated**: Created from one side only.
  - **Connected**: Established successfully in both directions.
- **Management Options**: Can be provisioned via Azure Portal, Azure PowerShell, Azure CLI, or Infrastructure as Code (Bicep/Terraform).

---

## Module 5: Determine Service Chaining Uses and Traffic Routing
- **Service Chaining**: Directs traffic from one VNet to a Network Virtual Appliance (NVA) or firewall in a peered VNet using User Defined Routes (UDRs).
- **Traffic Flow Control**:
  - *Allow forwarded traffic*: Enables a VNet to accept traffic from a remote VNet that originated elsewhere (critical for NVAs/firewalls).
- **Disable Peering Route Propagation**: Suppresses system-generated VNet peering routes so that custom UDRs take precedence, forcing traffic through a specific security appliance or NVA instead of bypassing it.

---

## Module 6: Simulation - Configure VNet Peering
- **Practical Exercise Structure**:
  - Deploying multiple VNets with non-overlapping address spaces across a target region (e.g., `austriaeast`).
  - Configuring bidirectional peering links between Core Services VNet and Manufacturing VNet.
  - Implementing User Defined Routes (UDRs) and handling route propagation adjustments.
  - Validating low-latency internal communication between deployed Windows Server virtual machines using connectivity tools (`Test-NetConnection`).

---

## Lab: Implement Intersite Connectivity (Lab 05)
- **Objective**: Build and validate a hub-and-spoke network topology utilizing Bicep modules or manual configurations.
- **Key Tasks**:
  - **Task 1 & 2**: Create core and manufacturing virtual networks, subnets, route tables, and virtual machines (`Standard_DS1_v2` running Windows Server 2025 Gen2 with boot diagnostics disabled).
  - **Task 3**: Configure VNet peering links between `CoreServicesVnet` and `ManufacturingVnet`.
  - **Task 4**: Configure custom route tables and disable BGP/peering route propagation for traffic enforcement.
  - **Task 5**: Test and verify inter-VNet connectivity using Azure CLI (`az vm run-command`) and PowerShell network diagnostics.

---

## Module 7: Knowledge Check
- **Core Review Points**:
  - Verifying non-overlapping IP address ranges before setting up peering.
  - Confirming bidirectional peering status (`Connected`) to enable active packet flow.
  - Understanding the mechanics of gateway transit and how spoke networks inherit hybrid connectivity without deploying redundant gateways.

---

## Module 8: Summary and Resources
- **Key Takeaways**:
  - VNet peering offers high-speed, secure, private connectivity via the Azure backbone.
  - Proper planning of IP address spaces and routing configurations (UDRs and transit gateways) ensures scalable enterprise cloud architectures.
- **Further Reading**: Official Microsoft documentation on Virtual Network Peering, Global Peering, and Hub-and-Spoke Network Topologies.


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

**3. Set default resource group:**

```powershell
az configure --defaults group="rg-bicep"
```

**4. Deploy the Bicep file to Azure:**

```powershell
az deployment group create --name main --template-file main.bicep
```

**5. Conectivity Check**
### Check IP adrese for CoreServicesVM
```powershell
az network nic show --resource-group rg-bicep --name nic-core --query 'ipConfigurations[0].privateIPAddress' -o tsv
```
### Test Connection from ManufacturingVM to CoreServicesVM
```powershell
az vm run-command invoke --resource-group rg-bicep --name ManufacturingVM --command-id RunPowerShellScript --scripts "Test-NetConnection -ComputerName 10.0.0.4 -Port 3389" --query "value[0].message" -o tsv
```

**6 . Cleanup: Deleting the Resource Group (rg-bicep)**

```powershell
az group delete --name rg-bicep --yes --no-wait
```