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
  - Log Analytics Workspace & Application Insights (for centralized telemetry and monitoring)

---

## 04 - Capstone Implementation Roadmap

### Phase 1: Monolithic Skeleton & Core Logic

- **01-monolithic-skeleton**
  - [ ] **1.1 Setup Project Structure:** Create the base workspace folders and initialize the primary `main.bicep` template.
  - [ ] **1.2 Define Core Variables & Parameters:** Set up hardcoded values for locations, environment names, and baseline configurations.
  - [ ] **1.3 Build Network Foundation:** Implement Virtual Networks and nested subnets using loops within the single file.
  - [ ] **1.4 Implement Database Tier:** Deploy Azure SQL Servers and child SQL databases using proper parent-child relationships and TLS baselines.
  - [ ] **1.5 Deploy Compute & Monitoring:** Add Log Analytics, Application Insights, App Service Plans, and Web Apps, linking telemetry strings.
  - [ ] **1.6 Secure Infrastructure:** Add Azure Key Vault resource definitions for secret management.
  - [ ] **1.7 Validate Graph & Dependencies:** Inspect the resource dependency graph in VS Code Visualizer to ensure proper implicit ordering.

- **02-add-outputs**
  - [ ] **2.1 Design Output Structure:** Plan what critical connection strings, FQDNs, and resource IDs need to be exposed.
  - [ ] **2.2 Construct Output Loops:** Write Bicep output blocks to aggregate regional server names and Fully Qualified Domain Names (FQDNs).
  - [ ] **2.3 Test Deployment Return Values:** Run a trial deployment of the monolithic skeleton and verify that all expected outputs render correctly in the CLI/portal.

---

### Phase 2: Refactoring & Modularization

- **01-module split**
  - [ ] **01.1 Architecture Breakdown:** Map out the directory structure (`modules/`) and define boundaries for each component.
  - [ ] **01.2 Isolate Network Module:** Extract VNet and subnet definitions into `modules/networking.bicep` with clean parameters and outputs.
  - [ ] **01.3 Isolate Database Module:** Move SQL Server and database logic into `modules/database.bicep`.
  - [ ] **01.4 Isolate Compute & Monitoring Module:** Extract App Service plans, Web Apps, and monitoring components into `modules/compute.bicep` and `modules/monitoring.bicep`.
  - [ ] **01.5 Isolate Security Module:** Extract Key Vault into `modules/keyvault.bicep`.
  - [ ] **01.6 Refactor Main Orchestrator:** Rewrite `main.bicep` to act purely as a module orchestrator, wiring outputs from one module into the inputs of another.

- **02-external-parameters**
  - [ ] **02.1 Identify Configurable Parameters:** Review all hardcoded variables and categorize them into environment-agnostic and environment-specific settings.
  - [ ] **02.2 Create Parameter Files:** Build dedicated JSON configuration files (e.g., `main.parameters.dev.json`, `main.parameters.prod.json`).
  - [ ] **02.3 Handle Secure Values:** Ensure passwords and secrets are mapped correctly using secure parameters and local credential references.
  - [ ] **02.4 Final End-to-End Validation:** Test the modularized deployment using the external parameter files to verify full automation readiness.