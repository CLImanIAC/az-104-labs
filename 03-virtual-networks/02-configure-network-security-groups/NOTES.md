# Azure Network Security Groups - Study Notes
---

## 1. Introduction & Overview
- **Objective:** Control network traffic to and from Azure resources within a virtual network using Network Security Groups (NSGs)[cite: 1].
- **Core Principle:** Limit exposure and prevent unauthorized or unsecured network traffic from reaching key application systems[cite: 1].

---

## 2. Implementing Network Security Groups
- **Association:** NSGs can be attached directly to **Subnets** or individual **Network Interfaces (NICs)** associated with virtual machines.
- **Best Practice:** Associating NSGs at the subnet level provides centralized, broad control for all resources residing within that specific subnet.

---

## 3. NSG Rule Architecture & Evaluation
- **Rule Components:** Priority (100 to 4096, where lower numbers execute first), Source, Port range, Destination, Port range, Protocol (TCP/UDP/ICMP), and Action (`Allow` or `Deny`).
- **Default Rules:** Pre-configured system rules that allow internal VNet communication and Azure Load Balancer probes while blocking inbound internet traffic by default.
- **Evaluation Order:** Evaluated based on priority; the first rule matching the traffic characteristics determines the action.

---

## 4. Effective Security Rules
- **Definition:** The combined result of all explicit administrator-defined rules and default system rules applied to a network interface.
- **Diagnostic Utility:** Essential troubleshooting feature in the Azure portal to inspect why a specific connection is allowed or blocked on a given VM NIC.

---

## 5. Creating and Managing NSG Rules
- **Least Privilege Principle:** Deny all unexpected traffic by default and explicitly open only necessary ports (e.g., port 443 for HTTPS, port 3389 for restricted RDP via Bastion).
- **Rule Uniqueness:** Every custom rule within an NSG must possess a unique priority number.

---

## 6. Application Security Groups (ASGs)
- **Function:** Enable logical grouping of virtual machine network interfaces (e.g., grouping all database VMs into an `ASG-DB`).
- **Benefit:** Allows you to use ASGs as sources or destinations in NSG rules, eliminating the need to manage hardcoded IP addresses when scaling application architectures.

---

## 7. Simulation & Lab Exercises
- **Practical Application:** Hands-on validation of configuring network security groups, assigning inbound/outbound rules, and testing connectivity within test environments.

---

## 8. Knowledge Check & Core Concepts
- **Exam Readiness:** Validates understanding of rule prioritization logic, subnet versus NIC traffic processing order, and proper scoping of security filters.

---

## 9. Summary & Resources
- **Key Takeaway:** Combining NSGs for Layer 4 packet filtering with ASGs for logical workload grouping forms the baseline perimeter and micro-segmentation defense in Azure.



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