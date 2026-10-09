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
- [ ] **01-monolithic-skeleton:** 
  - Write the initial single-file `main.bicep` incorporating all core resources (VNets with nested subnets, SQL servers/databases, App Service plans, Web Apps, Key Vault, and monitoring) with hardcoded parameters to master resource logic and dependencies.
- [ ] **02-add-outputs:** 
  - Construct output loops to aggregate regional server names, Fully Qualified Domain Names (FQDNs), and endpoints on the monolithic structure.

---

### Phase 2: Refactoring & Modularization
- [ ] **01-module split:** 
  - Break down the monolithic `main.bicep` file into clean, modularized components (`modules/networking.bicep`, `modules/database.bicep`, `modules/compute.bicep`, etc.) orchestrated by a clean main entry point.
- [ ] **02-external-parameters:** 
  - Externalize environment configurations and sensitive settings into dedicated parameter files (`main.parameters.json`).