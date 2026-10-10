# Lab Notes: Multi-Region Enterprise Architecture Lab (TeddyCorp)

## Overview

Building a scalable, multi-region Azure infrastructure using Bicep, following an incremental, human-centric development approach from a monolithic skeleton towards advanced enterprise patterns.

---

## Architecture Scope & Resources

The lab encompasses the following enterprise tiers and components:

- **Network Layer:**
  - Virtual Networks (VNets) across 3 regions with non-overlapping address spaces
  - Subnets (App and DB subnets per VNet, nested within loops)
- **Database Tier:**
  - Azure SQL Servers (Logical SQL Servers) in all 3 regions
  - Azure SQL Databases
- **Compute / Application Tier:**
  - App Service Plans
  - Web Apps (App Services)
- **Security & Management Tier:**
  - Azure Key Vault (for secrets and database credentials management)
  - Azure Resource Locks (`CanNotDelete`) for protection against accidental resource group deletion.
- **Monitoring Tier:**
  - Log Analytics Workspace & Application Insights (for centralized telemetry and monitoring)

---

## Roadmap & Implementation Details

### Phase 1: Monolithic Skeleton

- [ ] **01-monolithic-skeleton**
  - [ ] Create `main.bicep` inside the `01-monolithic-skeleton` folder.
  - [ ] **Define parameters and name resources according to conventions:**
    - Locations: `swedencentral`, `francecentral`, and `germanywestcentral`.
    - Environment: `dev`.
    - Application name: `teddycorp`.
  - [ ] **Network Layer (Using 3-region non-overlapping address spaces with 2 subnets each):**
    - Region 1 (West Europe): VNet `vnet-teddycorp-westeurope` (`10.1.0.0/16`), App Subnet (`10.1.1.0/24`), DB Subnet (`10.1.2.0/24`).
    - Region 2 (North Europe): VNet `vnet-teddycorp-northeurope` (`10.2.0.0/16`), App Subnet (`10.2.1.0/24`), DB Subnet (`10.2.2.0/24`).
    - Region 3 (France Central): VNet `vnet-teddycorp-francecentral` (`10.3.0.0/16`), App Subnet (`10.3.1.0/24`), DB Subnet (`10.3.2.0/24`).
  - [ ] **Database Tier:**
    - SQL Servers: `sql-teddycorp-westeurope`, `sql-teddycorp-northeurope`, and `sql-teddycorp-francecentral`.
    - **Secure Parameters for SQL:**
      - `sqlServerAdministratorLogin`: Admin username (default: `'sqladmin'`).
      - `sqlServerAdministratorPassword`: `@secure()` parameter for manual input during testing (avoiding plaintext hardcoding).
    - SQL Databases: `sqldb-teddycorp` linked via the `parent` property to their respective server.
  - [ ] **Compute Tier (App Service / Web Apps):**
    - App Service Plans: `plan-teddycorp-westeurope`, `plan-teddycorp-northeurope`, and `plan-teddycorp-francecentral` (Standard tier).
    - Web Apps: `app-teddycorp-westeurope`, `app-teddycorp-northeurope`, and `app-teddycorp-francecentral` linked to their respective plans.
  - [ ] **Security Tier:**
    - Resource Protection: Add a `CanNotDelete` Azure Resource Lock at the resource group level to prevent accidental deletion.
  - [ ] Validate the dependency graph in the VS Code Visualizer.

- [ ] **02-add-outputs**
  - [ ] **Define output blocks at the bottom of the script:**
    - `sqlServerFqdns`: Array/loop returning Fully Qualified Domain Names for all regional SQL servers (e.g., `sql-teddycorp-westeurope.database.windows.net`).
    - `webAppUrl`: Retrieved via `webApp.properties.defaultHostName` (the public URL of the web application).
  - [ ] Test the deployment and verify the return values in the CLI console.

---

### Phase 2: Refactoring, Security & Modularization

- [ ] **01-module split**
  - [ ] Create the `modules/` folder.
  - [ ] Dynamic Network Scaling (Loops): Refactor the fixed IP address pools from Phase 1 into dynamically generated multi-region loops using arrays for cleaner, scalable infrastructure code
  - [ ] Extract networking into `modules/networking.bicep` (handling multi-region loops).
  - [ ] Extract databases into `modules/database.bicep`.
  - [ ] Extract compute and monitoring into `modules/compute-monitoring.bicep`.
  - [ ] Extract Key Vault into `modules/keyvault.bicep`:
    - Key Vault naming convention: `kv-teddycorp-dev-${uniqueString(resourceGroup().id)}` _(must be globally unique across Azure due to global DNS)_.
  - [ ] Rewrite `main.bicep` to act purely as an orchestrator that calls modules and wires outputs (such as subnet IDs or FQDNs) from one module into another.

- [ ] **02-external-parameters & Secrets Automation**
  - [ ] Create `main.parameters.dev.json` and `main.parameters.prod.json`.
  - [ ] Data Extraction: Move hardcoded values (such as locations, names, and SKUs) into the JSON files.
  - [ ] Automated Secrets Management: Transition from manual `@secure()` CLI inputs to automated Key Vault secret retrieval for pipeline/production deployments.
  - [ ] Perform a final end-to-end test deployment using the parameter file.

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

**4a. Deploy the Bicep file to Azure:**

```powershell
az deployment group create --name main --template-file main.bicep
```

**4b. Deploy the Bicep file to Azure with parameters:**

```powershell
az deployment group create --name main --template-file main.bicep --parameters main.parameters.dev.bicepparam
```

**5. Check locks in resource group**

```powershell
az lock list --resource-group rg-bicep --output table
```

**6. Delete lock**

```powershell
az lock delete --name rg-lock-teddycorp --resource-group rg-bicep
```

**7 . Cleanup: Deleting the Resource Group (rg-bicep)**

```powershell
az group delete --name rg-bicep --yes --no-wait
```