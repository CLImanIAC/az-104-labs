# Summary: Secure Azure Resources with Azure RBAC

This module covers fine-grained access management for Azure resources using **Azure Role-Based Access Control (Azure RBAC)**. It details how Azure RBAC works, how to audit access, grant or revoke permissions, and review activity logs.

---

## 1. Overview & Azure RBAC Architecture
* **Azure RBAC Purpose**: An authorization system built on Azure Resource Manager that provides fine-grained access management over Azure resources (VMs, Storage, Databases, Virtual Networks).
* **Key Goal**: Enforce the **Principle of Least Privilege**, ensuring identities only have the permissions necessary to perform their roles.
* **Core Components**:
  1. **Security Principal**: Who receives access (Users, Groups, Service Principals, or Managed Identities).
  2. **Role Definition**: A collection of permissions (`Actions`, `NotActions`, `DataActions`, `NotDataActions`).
  3. **Scope**: The boundary/level where access applies (Management Group → Subscription → Resource Group → Resource). Inherited downwards.
  4. **Role Assignment**: The binding of a Security Principal to a Role Definition at a specific Scope.

---

## 2. Key Built-in Roles
Azure includes several built-in roles, categorized into General and Resource-Specific roles:
* **Owner**: Full access to all resources, including the ability to grant/revoke access to others (assign roles).
* **Contributor**: Full access to create and manage all types of Azure resources, but **cannot** grant/revoke access to others.
* **Reader**: Can view existing Azure resources, but cannot make any changes or create new ones.
* **User Access Administrator**: Allows managing user access to Azure resources (role assignments), but does not grant direct resource management permissions.
* **Resource-Specific Roles**: e.g., *Virtual Machine Contributor*, *Storage Account Contributor*, *Cost Management Reader*.

---

## 3. Auditing & Listing Access (`Access Control (IAM)`)
* **Access Control (IAM)** blade is available at every scope (Subscription, Resource Group, Resource).
* **Check Access / View My Access**: Allows users to check their own role assignments or see what access another principal has.
* **Role Assignments Tab**: Displays all explicit role assignments at the current scope as well as inherited assignments from parent scopes.
* **Deny Assignments**: Take precedence over Role Assignments. Created and managed by Azure (e.g., Azure Blueprints or Managed Applications) to block specific actions regardless of assigned roles.

---

## 4. Granting & Revoking Access
* **Prerequisite**: You must be assigned a role with role assignment write permissions (e.g., **Owner** or **User Access Administrator**).
* **Granting Access**:
  1. Navigate to the desired scope in the Azure Portal (or CLI/PowerShell/Terraform).
  2. Select **Access Control (IAM)** → **+ Add** → **Add role assignment**.
  3. Select the appropriate Role Definition.
  4. Assign to the target Security Principal (User, Group, or Service Principal).
* **Best Practice**: Assign roles to **Groups** rather than individual users whenever possible to simplify identity governance and onboarding/offboarding.
* **Revoking Access**: Locate the role assignment in the *Role assignments* tab and select **Remove**.

---

## 5. Monitoring via Activity Logs
* **Azure Activity Log**: A subscription-level log that tracks control-plane events, including all Azure RBAC changes (role assignments created, updated, or deleted).
* **Auditing RBAC Changes**:
  * Navigate to **Activity Log** under the Subscription or Resource Group.
  * Filter by **Operation name**: `Create role assignment` or `Delete role assignment`.
  * Allows security admins to track *who* granted or revoked access, *when* it occurred, and *at what scope*.

---

## 6. Key Takeaways & Best Practices
* **Least Privilege**: Always assign the minimum required role at the narrowest possible scope.
* **Use Groups**: Assign roles to Entra ID groups rather than individual user accounts.
* **Control vs. Data Plane**: Azure RBAC primarily manages the Control Plane (ARM), though specific Data Plane roles exist (e.g., Storage Blob Data Contributor).
* **Audit Regularly**: Continuously review role assignments using `IAM` blades and monitor changes in `Activity Log`.