
# AZURE BLOB STORAGE – MODULE SUMMARY

## 1. Introduction & Overview
- **Purpose:** Azure Blob Storage is Microsoft's massively scalable, AI-ready object storage solution designed for unstructured data (e.g., media files, documents, logs, backups).
- **Target Audience:** Prepared for Azure Administrators targeting **Exam AZ-104**.
- **Core Learning Objectives:**
  * Understand the architecture and benefits of Azure Blob Storage.
  * Create and configure storage accounts and containers.
  * Optimize storage costs using data access tiers and lifecycle rules.
  * Implement object replication for high availability and redundancy.

## 2. Implement Azure Storage & Blob Infrastructure
- **Storage Account Deployment:** Standard General Purpose v2 (GPv2) accounts form the baseline for Blob Storage.
- **Redundancy Models:**
  * **LRS / ZRS:** Local and zone redundancy for high availability within a primary region.
  * **GRS / RA-GRS:** Geo-redundant storage with optional read access to the secondary region for disaster recovery.
- **Security Baseline:** Secure transfer (HTTPS/TLS 1.2) is enabled by default. Public anonymous access is disabled globally at the account level unless explicitly allowed.

## 3. Create and Configure Blob Containers
- **Container Structure:** Flat namespace hierarchy used to organize blobs within a storage account.
- **Public Access Levels:**
  * **Private (no anonymous access):** Container and blob data restricted to authorized requests (Entra ID, Key, SAS).
  * **Blob (anonymous read access for blobs only):** Blob data within the container can be read via public URL, but container enumeration is blocked.
  * **Container (anonymous read access for container and blobs):** Allows public clients to enumerate blobs and read data freely.

## 4. Create and Manage Blob Access Tiers
- **Access Tier Options:**
  * **Hot Tier:** Optimized for frequently accessed data. Highest storage cost, lowest access/read cost.
  * **Cool Tier:** Optimized for infrequently accessed data (minimum 30 days retention). Lower storage cost, higher access cost.
  * **Cold Tier:** Optimized for rarely accessed data (minimum 90 days retention). Significantly lower storage cost than Cool.
  * **Archive Tier:** Offline tier for historical data (minimum 180 days retention). Lowest storage cost, high retrieval latency (hours).
- **Blob Rehydration:** Process of moving blobs from Archive back to Hot or Cool (Standard vs. High Priority rehydration).

## 5. Add Blob Lifecycle Management Rules
- **Automated Lifecycle Policies:** Rule-based management to transition data between tiers or auto-delete blobs based on prefix or blob type.
- **Supported Triggers:**
  * Days after creation (`daysAfterCreationGreaterThan`).
  * Days after last modification (`daysAfterModificationGreaterThan`).
  * Days after last access (`daysAfterLastAccessTimeGreaterThan`).
- **Use Case Example:** Move blobs from Hot to Cool after 30 days, move to Archive after 90 days, delete after 365 days.

## 6. Determine Blob Object Replication
- **Asynchronous Cross-Region Replication:** Copies block blobs asynchronously from a source container to a destination container across different storage accounts or regions.
- **Key Prerequisites:**
  * Blob Versioning must be enabled on both source and destination accounts.
  * Change Feed must be enabled on the source account.
- **Use Cases:** Minimizing latency for global users, backup consolidation, and regional compliance requirements.

## 7. Upload & Protect Blobs (Data Protection & Versioning)
- **Blob Soft Delete:** Retains deleted blobs or snapshots for a retention period (e.g., 7 to 365 days) allowing full restoration.
- **Container Soft Delete:** Protects entire deleted containers from accidental deletion.
- **Blob Versioning:** Automatically creates a read-only prior state version whenever a blob is overwritten or modified.
- **Upload Methods:** Azure Portal, Azure CLI, PowerShell, AzCopy tool, and Storage Explorer.

## 8. Determine Storage Pricing & Cost Optimization
- **Key Cost Drivers:**
  * **Capacity:** Gigabytes stored per month based on tier.
  * **Transactions:** Read, write, list, and change tier operation volumes.
  * **Data Transfer:** Outbound bandwidth (egress) and inter-region replication traffic.
  * **Data Retrieval:** Charges applied when reading or rehydrating data from Cool, Cold, or Archive tiers.
- **Cost Minimization Strategy:** Pair lifecycle policies with appropriate initial tier selection to avoid early deletion or early rehydration penalties.

## 9. Lab Simulation & Hands-on Workflows
- **Core Hands-on Tasks:**
  * Provisioning GPv2 Storage Accounts with `Standard_RAGRS` redundancy via Bicep / Portal.
  * Overriding global tenant settings (`allowBlobPublicAccess: true`) to expose a public container.
  * Uploading test assets and verifying Soft Delete restoration (`Show active and deleted blobs`).
  * Validating blob versioning history upon sequential file updates.

## 10. Knowledge Check & Core Concepts
- **RBAC vs. Access Keys:** Entra ID RBAC is preferred for fine-grained identity control; Access Keys bypass RBAC completely.
- **Access Tier Trade-offs:** Balancing latency requirements against transaction and retrieval unit costs.
- **Replication SLA:** GRS handles regional disasters; ZRS handles data center zone failures.

## 11. Summary & Next Steps
- **Key Takeaway:** Configuring Blob Storage effectively requires integrating public security boundaries, versioning/soft delete protection, and automated lifecycle rules to balance durability with optimal cloud expenditure.


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
az group create --name rg-bicep --location germanywestcentral
```

**3. Set default resource group:**

```powershell
az configure --defaults group="rg-bicep"
```

**4. Deploy the Bicep file to Azure:**

```powershell
az deployment group create --name main --template-file main.bicep
```

**5 . Cleanup: Deleting the Resource Group (rg-bicep)**

```powershell
az group delete --name rg-bicep --yes --no-wait
```