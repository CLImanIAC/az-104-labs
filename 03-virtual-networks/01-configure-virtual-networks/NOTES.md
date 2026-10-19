# Configure Virtual Networks - Summary

## 1. Introduction & Overview
- Azure virtual networks (VNets) are essential components for creating secure private networks in Azure, enabling safe communication between resources, the internet, and on-premises environments.
- Key use cases include creating isolated cloud-only networks or securely extending enterprise data centers into the cloud.

## 2. Planning Virtual Networks
- Proper planning involves defining address spaces using CIDR notation (e.g., `/16` for a VNet and `/24` for subnets).
- Consideration must be given to naming conventions, regional deployment, and future scalability to prevent IP overlap with on-premises networks or peered VNets.

## 3. Subnets & Subnetting
- Subnets allow you to segment a VNet's address space into smaller, manageable networks.
- Benefits include improved security, isolation, and organized resource allocation (e.g., separating frontend web tiers from backend database tiers).
- Certain IP addresses within each subnet are reserved by Azure (network address, broadcast, gateway, and DNS).

## 4. Creating Virtual Networks & IP Addressing
- VNets and subnets can be provisioned via the Azure Portal, Azure CLI, PowerShell, or Infrastructure-as-Code tools like Bicep.
- **Public IP Addresses:** Enable Azure resources (such as Virtual Machines or Load Balancers) to communicate inbound and outbound with the internet. They can be *Basic* or *Standard* SKU, and allocated as *Dynamic* or *Static*.
- **Private IP Addresses:** Allow Azure resources to communicate internally within a VNet or peered VNets without internet exposure. Assigned via DHCP or configured as static private IPs.

## 5. Simulations & Best Practices
- Best practices dictate applying the principle of least privilege using Network Security Groups (NSGs) alongside subnets.
- Proper IP planning ensures seamless integration during hybrid setups (such as connecting local data centers via ExpressRoute or VPN gateways).


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

**7 . Cleanup: Deleting the Resource Group (rg-bicep)**

```powershell
az group delete --name rg-bicep --yes --no-wait
```