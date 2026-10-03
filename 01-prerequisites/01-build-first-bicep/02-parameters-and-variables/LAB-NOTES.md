# Lab Notes: Parameters, Variables, and Azure Resource Hierarchy

## Key Learnings:

### 1. Parameters vs. Variables
- **Parameters (`param`)**: Used for external inputs and dynamic configurations. They allow flexibility because their values can be overridden at deployment time.
- **Variables (`var`)**: Used for internal, fixed logic within the template. They are hidden from external users and cannot be overridden during deployment.

### 2. Naming Conventions & Global Uniqueness
- **Globally Unique Names**: Resources exposed to the public internet (such as Storage Accounts and App Service apps) require globally unique names across all of Azure. We achieve this using functions like `uniqueString(resourceGroup().id)`.
- **Scoped Uniqueness**: Internal resources (such as App Service plans) only require names that are unique within their specific resource group, acting like local infrastructure hosting.

### 3. Azure Resource Hierarchy & Governance
- **Management Groups & Subscriptions**: Provide the top-level financial, administrative, and compliance boundaries. Policies applied here cascade down.
- **Resource Groups**: Act as logical containers (similar to Organizational Units in Active Directory) used for lifecycle management, environment separation (Dev/Test/Prod), and security isolation via Role-Based Access Control (RBAC).