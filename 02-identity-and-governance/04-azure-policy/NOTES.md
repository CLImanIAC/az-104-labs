# Summary: Sovereignty Policy Initiatives in Azure

This module explains how to use **Azure Policy** and **Azure Policy Initiatives** to establish control, security boundaries, and compliance with national and regional regulatory requirements as well as data sovereignty standards.

---

## 1. Overview
* **Azure Policy**: A service that enables the creation, assignment, and management of governance policies to ensure resource compliance with organizational standards.
* **Azure Policy Initiatives**: Grouped definitions of multiple individual policies aligned toward a specific goal or regulatory framework (e.g., Sovereignty, public sector, financial regulations).
* **Purpose**: Accelerating digital transformation in the public sector and regulated industries by reducing audit times and automatically enforcing security guardrails.

---

## 2. Cloud Adoption Framework (CAF) for Azure
* **CAF Govern Methodology**: Provides a systematic framework for establishing and continuously improving cloud governance through 5 key steps:
  1. *Build a governance team*
  2. *Assess cloud risks* (Business and technical risks)
  3. *Document cloud governance policies*
  4. *Enforce cloud governance policies* (Using automated tools)
  5. *Monitor cloud governance*
* **5 Core Disciplines of Governance**:
  * **Cost Management**
  * **Security Baseline**
  * **Resource Consistency** (Resource and tag standardization)
  * **Identity Baseline** (Identity and Access Management)
  * **Deployment Acceleration** (Automation and deployment standardization)
* **Role of Azure Policy in CAF**: Serves as the primary tool for establishing guardrails, preventing misconfigurations, enabling automated remediation, and tracking compliance via the compliance dashboard.

---

## 3. Azure Policy Design Principles
* **Governance Hierarchy**:
  * **Tenant Root Group → Management Groups (up to 6 levels) → Subscriptions → Resource Groups → Resources**.
  * Policies defined at higher levels are automatically **inherited** by lower scopes.
* **Control Plane vs. Data Plane**:
  * **Control Plane (Azure Resource Manager - ARM)**: Manages operations on resources (creation, deletion, updates). Azure Policy primarily operates at the Control Plane layer (after RBAC evaluation).
  * **Data Plane**: Direct interaction with data inside resources (e.g., Key Vault secrets, SQL queries, Kubernetes pods). Supported via specific *Resource Provider modes* (e.g., `Microsoft.KeyVault.Data`, `Microsoft.Kubernetes.Data`).
* **Evaluation Scenarios (Greenfield vs. Brownfield)**:
  * **Greenfield (Policy-first)**: Real-time evaluation occurs during resource creation or modification.
  * **Brownfield (Resource-first)**: Applying a new policy to pre-existing resources. Evaluation runs via a *compliance scan* every 24 hours (or triggered manually). Non-compliant resources are flagged, but not automatically deleted.

---

## 4. Azure Policy Resources
Within Azure Policy, there are 6 key resources and concepts:
1. **Definitions**: JSON files that describe compliance conditions and the effect (action) to take. Can be *Built-in* or *Custom*.
2. **Initiatives**: Groups of related policy definitions (also in JSON). Also known as *Policy Sets*.
3. **Assignments**: Applying a policy definition or initiative to a specific *scope* (Management Group, Subscription, or Resource Group).
   * Supports *Parameters*, *Enforcement Mode* (enables "What-if" analysis without blocking deployments), *Excluded Scopes*, and *Resource Selectors*.
4. **Exemptions**: Temporarily or permanently exempting a resource hierarchy or individual resource from evaluation. Categorized as:
   * **Mitigated**: Intent met through alternative means.
   * **Waiver**: Temporary acceptance of non-compliance state.
5. **Attestations**: Used by manual policies to declare compliance states for resources that cannot be automatically evaluated.
6. **Remediations**: Tasks used to bring existing non-compliant resources into compliance (for `deployIfNotExists` and `modify` effects).

---

## 5. Azure Policy Definitions
Structure of a JSON policy definition includes:
* **metadata / displayName / description**: Contextual details and categorizations.
* **mode**: Determines whether ARM properties (`Indexed`, `All`) or Data Plane properties (`Microsoft.KeyVault.Data`, etc.) are evaluated.
* **parameters**: Enables policy reuse across various scenarios with different inputs (e.g., allowed locations).
* **policyRule**: Contains **`if`** and **`then`** blocks:
  * **`if` (Conditions)**: Uses logical operators (`allOf`, `anyOf`, `not`) to target properties (`field`), direct values (`value`), or array counts (`count`).
  * **`then` (Effects)**: Defines the action taken when conditions evaluate to true.

### Primary Policy Effects (`effects`):
* **`Deny`**: Blocks creation/update of non-compliant resources.
* **`Disabled`**: Turns off rule evaluation.
* **`Audit` / `AuditIfNotExists`**: Generates a non-compliance alert/log without blocking actions.
* **`Append`**: Adds required fields/properties to a resource during creation.
* **`Modify`**: Adds, updates, or removes properties and tags on resources.
* **`DeployIfNotExists`**: Automatically deploys a missing related resource (e.g., diagnostic settings).
* **`Manual`**: Requires manual attestation of compliance.

---

## 6. Evaluation, Check, and Module Summary
* **Evaluation Cycle**: Triggers during ARM payload requests (Greenfield) and through periodic scanning (Brownfield).
* **Sovereignty Portfolio**: Microsoft provides open-source *custom policy initiatives* and *compliance mappings* via the **industry-policy-portfolio** repository on GitHub to meet specific national and regional sovereignty and data protection mandates.
* **Conclusion**: By combining a properly structured governance hierarchy, tailored policy initiatives, and automated remediation, organizations can thoroughly secure their cloud environments and satisfy strict regulatory requirements without slowing down development speed.