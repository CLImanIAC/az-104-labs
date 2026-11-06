# AZURE STORAGE ACCOUNTS – MODULE SUMMARY

## 1. Introduction & Overview
* **Purpose:** Azure Storage is Microsoft's scalable, durable cloud storage solution designed for modern data scenarios (e.g., e-commerce product images, high traffic).
* **Target Audience:** Designed for Azure Administrators preparing for **Exam AZ-104**.
* **Core Learning Objectives:**
  * Identify storage account features and use cases.
  * Select appropriate Azure Storage types and create accounts.
  * Choose the right replication strategy.
  * Configure secure network access to storage endpoints.

## 2. Implement Azure Storage
* **Storage Account Foundation:** A storage account provides a unique namespace in Azure for your data, accessible from anywhere in the world over HTTP/HTTPS.
* **Key Components:**
  * Subscription & Resource Group placement.
  * Region selection (must align with data residency and latency requirements).
  * Performance tiers (Standard vs. Premium based on IOPS and throughput needs).

## 3. Explore Azure Storage Services
Azure Storage offers multiple core data services tailored to different data types:
* **Blobs:** Massive scalable object store for text and binary data (includes Azure Data Lake Storage Gen2 for big data analytics).
* **Files:** Managed file shares for cloud or on-premises deployments (SMB and NFS protocols).
* **Queues:** Messaging store for reliable asynchronous messaging between application components.
* **Tables:** NoSQL key-value store for unstructured tabular data.
* **Disks:** Managed virtual disks for Azure Virtual Machines.

## 4. Determine Storage Account Kinds
Choosing the right storage account type depends on workload requirements:
* **Standard General Purpose v2 (GPv2):** Recommended for most scenarios; supports blobs, files, queues, and tables with the latest features.
* **Premium Block Blobs:** Optimized for high-transaction rates or low-latency storage scenarios.
* **Premium File Shares:** High-performance file shares built for enterprise or high-IOPS applications.
* **Premium Page Blobs:** Optimized specifically for Azure VM disks.

## 5. Determine Replication Strategies
Azure replicates data to ensure durability and high availability against planned and unplanned events:
* **Locally Redundant Storage (LRS):** Copies data synchronously 3 times within a single physical location in the primary region. Lowest cost, lowest durability against regional disasters.
* **Geo-Redundant Storage (GRS):** Copies LRS data synchronously locally, then asynchronously to a secondary region hundreds of miles away.
* **Zone-Redundant Storage (ZRS):** Replicates data synchronously across three Azure availability zones in the primary region.
* **Geo-Zone-Redundant Storage (GZRS):** Combines ZRS high availability across zones with GRS geo-replication to a secondary region.
* *Read-Access Geo-Redundant / Geo-Zone-Redundant (RA-GRS / RA-GZRS):* Allows read access to data in the secondary region.

## 6. Access Storage
* **Authentication Methods:**
  * **Microsoft Entra ID:** Recommended security standard using OAuth 2.0 tokens and RBAC.
  * **Access Keys:** Account-level master keys providing full control over the storage account (use with caution).
  * **Shared Access Signatures (SAS):** Granular, time-bound delegated access tokens with specific permissions to resources.

## 7. Secure Storage Endpoints
* **Network Security Controls:**
  * **Public Endpoints & Firewalls:** Restricting access to specific public IP ranges or virtual networks.
  * **Private Endpoints (Azure Private Link):** Assigns a private IP from a virtual VNet to the storage account, keeping traffic entirely within the Microsoft backbone network.
  * **Service Endpoints:** Secures virtual network traffic paths to Azure storage services.
* **Encryption:** Data is encrypted at rest (Microsoft-managed or customer-managed keys via Azure Key Vault) and in transit (HTTPS/TLS).