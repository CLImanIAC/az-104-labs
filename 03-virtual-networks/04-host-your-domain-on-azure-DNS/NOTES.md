# Host a Domain in Azure DNS - Module Summary

## 1. Introduction
* **Overview:** Introduces Azure DNS as a cloud-hosted Domain Name System service integrated into Azure infrastructure, utilizing the same tools, billing, and APIs as other Azure services[cite: 1].
* **Scenario:** Managing the custom domain `wideworldimporters.com` bought from a third-party registrar to resolve web server IP addresses[cite: 1].

## 2. What Is Azure DNS?
* **Functionality:** Provides name resolution using Microsoft Azure infrastructure with high performance and reliability.
* **Integration & Security:** Offers role-based access control (RBAC), activity logs, and resource locking. 
* **Limitation:** Does not natively support Domain Name System Security Extensions (DNSSEC), requiring third-party providers (like Cloudflare) for enterprise DNSSEC compliance.

## 3. Configure Azure DNS to Host a Domain
* **DNS Zones:** A DNS zone hosts DNS records for a specific domain[cite: 1]. Zones are created globally within Azure.
* **Domain Delegation:** Involves getting Azure name server (NS) records and updating them at the third-party domain registrar so queries point to Azure DNS name servers[cite: 1].
* **Verification:** Validates successful domain delegation by querying the Start of Authority (SOA) record using tools like `nslookup`[cite: 1].

## 4. Exercise - Create a DNS Zone and an A Record
* **Practical Steps:** Creating a public DNS zone for a custom domain via the Azure Portal or command line.
* **Record Management:** Creating standard record sets, such as an `A` record mapping `www` to an IP address (e.g., `10.10.10.10`), and inspecting the automatically generated SOA and NS records[cite: 4].

## 5. Resolve Names by Using Alias Records
* **Alias Records Purpose:** Special proprietary record types in Azure that tightly couple DNS records with underlying Azure resources.
* **Key Benefits:**
  * Prevents dangling DNS records and potential subdomain takeover.
  * Automatically updates DNS record sets when underlying resource IP addresses change.
  * Supports zone apex routing for Traffic Manager and Content Delivery Network (CDN) endpoints.

## 6. Exercise - Create Alias Records
* **Implementation:** Configuring alias records to point zone apex or subdomains directly to Azure resources (such as Public IP addresses or Traffic Manager profiles) instead of static IP addresses.

## 7. Summary
* **Conclusion:** Reviews how Azure DNS manages public and private name resolution, integrates with Azure resources via alias records, and streamlines cloud-based domain administration.


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