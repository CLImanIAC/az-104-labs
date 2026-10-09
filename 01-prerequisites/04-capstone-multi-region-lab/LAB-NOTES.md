# Lab Notes: Multi-Region Enterprise Architecture Lab (TeddyCorp)

## Overview
Building a scalable, multi-region Azure infrastructure using Bicep, following an incremental, human-centric development approach from a monolithic skeleton towards advanced enterprise patterns.

---

## Phase 1: Monolithic Skeleton & Core Logic (Current)
- [ ] **Step 1: Network Foundation**
  - Configure multi-region Virtual Networks using resource loops.
  - Implement nested loops for automated subnet generation within each VNet.
- [ ] **Step 2: Database Layer**
  - Deploy Azure SQL Servers across target regions using loops.
  - Apply deployment pacing (`@batchSize(1)`) to control creation speed.
  - Attach regional databases as child resources using the `parent` property and proper TLS 1.2 baselines.
- [ ] **Step 3: Deployment Outputs**
  - Construct output loops to aggregate regional server names and Fully Qualified Domain Names (FQDNs).
- [ ] **Step 4: Parameterization**
  - Define robust parameters with descriptions and secure decorators.

---

## Phase 2: Refactoring & Modularization (Upcoming)
- [ ] **Module Split:** Break down the monolithic `main.bicep` file into clean, reusable modules (`modules/networking.bicep` and `modules/database.bicep`).
- [ ] **External Parameters:** Move configurations out into `azuredeploy.parameters.json`.
