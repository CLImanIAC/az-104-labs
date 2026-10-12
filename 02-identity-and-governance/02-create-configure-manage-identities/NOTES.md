# Exam Notes: Microsoft Entra Identities & Licensing

## 1. User Management & Lifecycle
* **Cloud vs. Synced Users:** Cloud-only identities are managed natively in Microsoft Entra ID. Synced identities originate from an on-premises Active Directory and are synchronized using Microsoft Entra Connect or Microsoft Entra Cloud Sync.
* **Guest Users (B2B Collaboration):** External users invited into your tenant. They authenticate against their home directory, but are provisioned and managed as guest objects in your tenant.
* **Soft Delete & Restoration:** Deleted user accounts are retained in the Deleted users container for 30 days. During this window, they can be fully restored along with their attributes, group memberships, and properties. After 30 days, they are permanently purged (hard delete).

## 2. Group Management & Membership Types
* **Security Groups:** Used to manage user and device access to shared resources (such as Azure RBAC roles, applications, and SharePoint sites). Can be assigned or dynamic.
* **Microsoft 365 Groups:** Collaboration-focused groups that automatically provision shared mailboxes, calendars, and SharePoint document storage.
* **Membership Assignment Rules:**
  * **Assigned (Static):** Members are added and removed manually.
  * **Dynamic Groups:** Membership rules use attributes (e.g., `user.department -eq "Security"`) to automatically manage members. Requires Microsoft Entra ID P1 or P2 license.

## 3. Device Identity States
* **Microsoft Entra Registered:** Typically BYOD or personal mobile devices added via user accounts. Managed via Intune or MDM.
* **Microsoft Entra Joined:** Cloud-only organization-owned devices. Users sign in with organizational credentials.
* **Microsoft Entra Hybrid Joined:** Devices joined to an on-premises Active Directory and synchronized/registered into Entra ID for unified management and Conditional Access policy enforcement.

## 4. Licensing & Common Pitfalls
* **Assignment Methods:** Licenses can be assigned directly to individual user accounts or automated using Group-based Licensing (recommended for enterprise scale).
* **Usage Location Requirement:** A user's Usage Location property (country/region code) must be explicitly configured before any product license can be assigned to them.
* **DependencyViolation Error:** Occurs when trying to remove a license containing a service plan that is still depended upon by another active service.
  * **Resolution:** Reassign or remove the dependent service dependencies before removing the base license.

## 5. Custom Security Attributes
* **Purpose:** Extend user and application profiles with custom metadata (key-value pairs) to support attribute-based access control (ABAC) scenarios.
* **Administrative Permissions:** Access and management require specific roles such as Attribute Definition Administrator or Attribute Assignment Administrator. Note that Global Administrators do not automatically receive assignment rights to custom security attributes without explicit role assignment.