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
    - Locations: `westeurope`, `northeurope`, and `francecentral`.
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
  - [ ] **Compute & Monitoring Tier:**
    - Log Analytics: `log-teddycorp-dev`.
    - Application Insights: `appi-teddycorp-dev` (linked to the Log Analytics workspace ID).
    - App Service Plan & Web App: `plan-teddycorp-dev` and `app-teddycorp-dev`.
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
  - [ ] Extract networking into `modules/networking.bicep` (handling multi-region loops).
  - [ ] Extract databases into `modules/database.bicep`.
  - [ ] Extract compute and monitoring into `modules/compute-monitoring.bicep`.
  - [ ] Extract Key Vault into `modules/keyvault.bicep`:
    - Key Vault naming convention: `kv-teddycorp-dev-${uniqueString(resourceGroup().id)}` *(must be globally unique across Azure due to global DNS)*.
  - [ ] Rewrite `main.bicep` to act purely as an orchestrator that calls modules and wires outputs (such as subnet IDs or FQDNs) from one module into another.

- [ ] **02-external-parameters & Secrets Automation**
  - [ ] Create `main.parameters.dev.json` and `main.parameters.prod.json`.
  - [ ] Data Extraction: Move hardcoded values (such as locations, names, and SKUs) into the JSON files.
  - [ ] Automated Secrets Management: Transition from manual `@secure()` CLI inputs to automated Key Vault secret retrieval for pipeline/production deployments.
  - [ ] Perform a final end-to-end test deployment using the parameter file.

## 🚀 Practical Exercise Workflow & Commands

### 0. Setup & Environment Configuration
Ensure Bicep CLI is up to date:
az bicep install && az bicep upgrade

Sign in to Azure:
az login

Create resource group:
az group create --name rg-bicep --location swedencentral

Set default resource group:
az configure --defaults group="rg-bicep"

Deploy the Bicep file to Azure:
az deployment group create --name main --template-file D:\Azure\01-prerequisites\03-build-felxible-bicep\03-variable-and-output-loops\main.bicep

Cleanup: Deleting the Resource Group (rg-bicep)
az group delete --name rg-bicep --yes --no-wait