# Lab Notes: Multi-Region Enterprise Architecture Lab (TeddyCorp)

## Overview
Building a scalable, multi-region Azure infrastructure using Bicep, following an incremental, human-centric development approach from a monolithic skeleton towards advanced enterprise patterns.

---

## Architecture Scope & Resources
The lab encompasses the following enterprise tiers and components:
- **Network Layer:**
  - Virtual Networks (VNets)
  - Subnets (nested within VNet loops)
- **Database Tier:**
  - Azure SQL Servers (Logical SQL Servers)
  - Azure SQL Databases
- **Compute / Application Tier:**
  - App Service Plans
  - Web Apps (App Services)
- **Security & Management Tier:**
  - Azure Key Vault (for secrets and database credentials management)
- **Monitoring Tier:**
  - Log Analytics Workspace & Application Insights (for centralized telemetry and monitoring)

---

## Roadmap & Implementation Details

### Phase 1: Monolithic Skeleton

- [ ] **01-monolithic-skeleton**
  - [ ] Create `main.bicep` inside the `01-monolithic-skeleton` folder.
  - [ ] **Define parameters and name resources according to conventions:**
    - Locations: `westeurope` and `northeurope`.
    - Environment: `dev`.
    - Application name: `teddycorp`.
    - Key Vault name example: `kv-teddycorp-dev-${uniqueString(resourceGroup().id)}` (must be globally unique across Azure due to global DNS).
  - [ ] **Network Layer (Using multi-region non-overlapping address spaces):**
    - Region 1 (West Europe): VNet `vnet-teddycorp-westeurope` (`10.1.0.0/16`), App Subnet (`10.1.1.0/24`), DB Subnet (`10.1.2.0/24`).
    - Region 2 (North Europe): VNet `vnet-teddycorp-northeurope` (`10.2.0.0/16`), App Subnet (`10.2.1.0/24`), DB Subnet (`10.2.2.0/24`).
  - [ ] **Database Tier:**
    - SQL Servers: `sql-teddycorp-westeurope` and `sql-teddycorp-northeurope`.
    - SQL Databases: `sqldb-teddycorp` linked via the `parent` property to their respective server.
  - [ ] **Compute & Monitoring Tier:**
    - Log Analytics: `log-teddycorp-dev`.
    - Application Insights: `appi-teddycorp-dev` (linked to the Log Analytics workspace ID).
    - App Service Plan & Web App: `plan-teddycorp-dev` and `app-teddycorp-dev`.
  - [ ] **Security Tier:**
    - Key Vault: Store the SQL server administrator password.
  - [ ] Validate the dependency graph in the VS Code Visualizer.

- [ ] **02-add-outputs**
  - [ ] **Define output blocks at the bottom of the script:**
    - `sqlServerFqdn`: Retrieved via `sqlServer.properties.fullyQualifiedDomainName` (the exact address used to connect to the database, e.g., `sql-teddycorp-westeurope.database.windows.net`).
    - `webAppUrl`: Retrieved via `webApp.properties.defaultHostName` (the public URL of the web application).
  - [ ] Test the deployment and verify the return values in the CLI console.

---

### Phase 2: Refactoring & Modularization

- [ ] **01-module split**
  - [ ] Create the `modules/` folder.
  - [ ] Extract networking into `modules/networking.bicep`.
  - [ ] Extract databases into `modules/database.bicep`.
  - [ ] Extract compute and monitoring into `modules/compute-monitoring.bicep`.
  - [ ] Extract Key Vault into `modules/keyvault.bicep`.
  - [ ] Rewrite `main.bicep` to act purely as an orchestrator that calls modules and wires outputs (such as subnet IDs or FQDNs) from one module into another.

- [ ] **02-external-parameters**
  - [ ] Create `main.parameters.dev.json` and `main.parameters.prod.json`.
  - [ ] **Data Extraction:** Move hardcoded values (such as locations, names, and SKUs) into the JSON files, while leaving sensitive SQL passwords as secure parameters provided at deployment time.
  - [ ] Perform a final end-to-end test deployment using the parameter file.