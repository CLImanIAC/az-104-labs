# Module Notes: Understand Microsoft Entra ID

## 1. Introduction & Core Concept
* **Microsoft Entra ID:** A multi-tenant, cloud-based platform-as-a-service (PaaS) identity and access management (IAM) solution.
* **Primary Focus:** Designed for web-based applications, cloud services (e.g., Microsoft 365, Azure Portal, SaaS apps), identity federation, and modern device management.
* **Built-In Features:** Includes native support for Multi-Factor Authentication (MFA), Identity Protection, and Self-Service Password Reset (SSPR).

---

## 2. Microsoft Entra ID vs. Traditional AD DS (Active Directory Domain Services)
* **AD DS (On-Premises):**
  * Runs on Windows Server (Domain Controllers).
  * Relies on protocols like **Kerberos, LDAP, and DNS**.
  * Features a hierarchical structure (Forests, Domains, Organizational Units / OUs) and traditional Group Policy Objects (GPOs).
* **Microsoft Entra ID (Cloud):**
  * Runs as a managed cloud service.
  * Relies on modern web protocols like **HTTPS, REST APIs, OAuth 2.0, OpenID Connect (OIDC), and SAML**.
  * Features a **flat structure** (no traditional OUs or classic GPOs; object grouping is handled via groups instead).

---

## 3. Tenants, Subscriptions, and Namespaces
* **Tenant:** Represents an individual, isolated instance of Microsoft Entra ID (multitenant by design). Acts as a security boundary and a container for directory objects (users, groups, applications).
* **Azure Subscriptions & Tenants:**
  * An Azure subscription must be associated with **one and only one** Microsoft Entra tenant at a time.
  * A single Microsoft Entra tenant can be associated with **multiple Azure subscriptions**.
* **Domain Names:**
  * Every tenant receives a default DNS domain name with the **`.onmicrosoft.com`** suffix.
  * Organizations can add and verify custom domain names matching their corporate namespace.

---

## 4. Schema and Object Management
* **Schema Differences:** Microsoft Entra ID contains fewer object types than AD DS; it lacks the traditional computer class (uses a *device* class instead) and OU class.
* **Applications and Service Principals:**
  * **Application object:** Contains the global definition of an application.
  * **Service Principal object:** Constitutes an instance of the application within a specific tenant, handling access and permissions.

---

## 5. Directory Service for Cloud Apps
* Entra ID acts as the central cloud directory service, providing authentication and authorization for:
  * Microsoft 365 and external SaaS applications (Salesforce, GitHub, etc.).
  * Internal cloud apps via App Registrations and Enterprise Applications.
  * Single Sign-On (SSO) capabilities across integrated platforms.

---

## 6. Microsoft Entra ID Tiers (Free vs. P1 vs. P2)
* **Free Tier:**
  * Included automatically with Azure subscriptions and Microsoft Online business services (M365, Intune).
  * Covers basic user/group management, directory synchronization, basic reports, and SSO for up to 10 apps per user.
* **Premium P1 Tier:**
  * Focused on **hybrid identity and advanced access control**.
  * Key features: **Conditional Access** policies (based on location, device state, and risk), dynamic group membership, and SSPR with on-premises password write-back.
* **Premium P2 Tier:**
  * Focused on **identity protection, security, and governance**.
  * Key features: **Microsoft Entra Identity Protection** (automated risk detection/remediation) and **Privileged Identity Management (PIM)** (Just-In-Time access and approval workflows for administrative roles).

---

## 7. Microsoft Entra Domain Services (AAD DS)
* **Definition:** Fully managed domain controllers in Azure provided as a service, eliminating the need to deploy and patch VM-based DCs.
* **Use Cases:** Running legacy cloud workloads and applications that require traditional **Kerberos, NTLM authentication, or LDAP queries**, as well as managing domain-joined virtual machines requiring classic Group Policies.


# AZ-104: Microsoft Entra ID - Practice Exam Questions

### Question 1: Conditional Access Licensing Requirement
**Question:** Your company wants to implement Conditional Access policies to block sign-ins from unfamiliar locations and require multi-factor authentication (MFA) based on risk levels. Which Microsoft Entra ID license tier is required for all users targeted by these policies?
* **A)** Microsoft Entra ID Free
* **B)** Microsoft Entra ID P1
* **C)** Microsoft Entra ID P2
* **D)** Microsoft Entra ID Governance

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** B
* **Explanation:** Conditional Access policies and dynamic groups require Microsoft Entra ID P1.
</details>

---

### Question 2: Privileged Identity Management (PIM)
**Question:** An administrator needs to ensure that IT staff can elevate their privileges to Global Administrator only for a specified time frame (e.g., 2 hours) and require manager approval for the elevation. Which feature and license tier should you use?
* **A)** Conditional Access with Microsoft Entra ID P1
* **B)** Privileged Identity Management (PIM) with Microsoft Entra ID P2
* **C)** Entra Domain Services with P1
* **D)** Self-Service Password Reset with Free tier

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** B
* **Explanation:** Privileged Identity Management (PIM) provides Just-In-Time (JIT) access, time-bound elevation, and approval workflows, which require Microsoft Entra ID P2.
</details>

---

### Question 3: Legacy Applications in Azure
**Question:** Your organization is migrating a legacy line-of-business application to Azure. The application requires traditional Kerberos and NTLM authentication and relies on LDAP queries. You do not want to manage domain controller virtual machines manually. What should you deploy?
* **A)** Microsoft Entra ID Free
* **B)** Microsoft Entra Domain Services (AAD DS)
* **C)** Azure SQL Managed Instance with Active Directory authentication
* **D)** Read-Only Domain Controller (RODC) on an Azure VM

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** B
* **Explanation:** Microsoft Entra Domain Services (AAD DS) provides fully managed domain controllers in Azure that support legacy protocols like Kerberos, NTLM, and LDAP without requiring you to manage VMs.
</details>

---

### Question 4: Hybrid Identity Source of Authority
**Question:** Your company uses a hybrid identity model with an on-premises Active Directory Domain Services (AD DS) environment synchronized to Microsoft Entra ID using Microsoft Entra Connect. Where must an administrator modify the user's primary email address (mail attribute) for a synchronized user?
* **A)** Directly in the Microsoft Entra ID portal
* **B)** In the local on-premises AD DS environment
* **C)** Via Azure Cloud Shell using the Az PowerShell module
* **D)** By modifying the Enterprise Application properties in Entra ID

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** B
* **Explanation:** For objects synchronized from an on-premises environment, the local AD DS remains the source of authority. Modifications to core attributes must be made on-premises and synced over.
</details>

---

### Question 5: Entra ID vs. Traditional AD Protocols
**Question:** Which protocols are natively supported by Microsoft Entra ID for cloud-based authentication and authorization, unlike traditional AD DS which relies on Kerberos? (Choose two)
* **A)** LDAP
* **B)** SAML
* **C)** NTLM
* **D)** OpenID Connect (OIDC)
* **E)** Kerberos

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** B, D
* **Explanation:** Microsoft Entra ID is built on modern web standards and protocols such as SAML, OAuth 2.0, and OpenID Connect (OIDC). LDAP, NTLM, and Kerberos are legacy on-premises protocols.
</details>

---

### Question 6: Enterprise Application Single Sign-On (SSO)
**Question:** You are configuring a third-party SaaS application in Microsoft Entra ID to allow employees to sign in using their corporate credentials. Which feature allows you to configure SAML-based Single Sign-On for this application?
* **A)** Microsoft Entra Domain Services
* **B)** Enterprise Applications
* **C)** App Registrations
* **D)** Managed Identities for Azure Resources

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** B
* **Explanation:** Enterprise Applications are used to manage pre-integrated SaaS apps, gallery apps, and non-gallery apps configured for Single Sign-On (SSO) and provisioning within your tenant.
</details>

---

### Question 7: Self-Service Password Reset (SSPR)
**Question:** You want to allow users to reset their own passwords without contacting the helpdesk. In which Microsoft Entra ID tier is SSPR fully available with write-back capabilities to an on-premises Active Directory?
* **A)** Free
* **B)** P1 or P2
* **C)** Only in P2 with Identity Protection
* **D)** Azure Basic tier

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** B
* **Explanation:** Basic SSPR is available in Free, but writing passwords back to an on-premises environment (password write-back) requires Microsoft Entra ID P1 or P2.
</details>

---

### Question 8: External Collaboration (B2B)
**Question:** A partner company needs access to certain internal Azure resources and SharePoint sites in your tenant without creating a permanent internal user account. What feature should you use?
* **A)** Microsoft Entra B2B collaboration
* **B)** Microsoft Entra Domain Services
* **C)** Custom security attributes
* **D)** Multi-Tenant Organization sync via P2

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** A
* **Explanation:** Microsoft Entra B2B collaboration allows you to invite guest users from external organizations to safely access your corporate resources.
</details>

---

### Question 9: Dynamic Groups
**Question:** You want a security group to automatically include all users whose department attribute is set to "Sales". What type of group configuration and license are required?
* **A)** Assigned membership using Entra ID Free
* **B)** Dynamic user membership using Microsoft Entra ID P1 or P2
* **C)** Dynamic device membership using Free tier
* **D)** Microsoft 365 group with Assigned membership

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** B
* **Explanation:** Dynamic groups (both for users and devices) evaluate rules based on user attributes and require a Microsoft Entra ID P1 or P2 license.
</details>

---

### Question 10: Azure AD Connect / Entra Connect Health
**Question:** You need to monitor the synchronization status, replication errors, and performance of your hybrid identity infrastructure between on-premises AD and Microsoft Entra ID. What built-in tool should you use?
* **A)** Microsoft Entra Connect Health
* **B)** Azure Monitor Application Insights
* **C)** Azure Bastion
* **D)** Log Analytics Workspace custom queries

<details>
<summary><b>Show Answer and Explanation</b></summary>

* **Correct Answer:** A
* **Explanation:** Microsoft Entra Connect Health helps you monitor and gain deep visibility into your on-premises identity infrastructure and synchronization services.
</details>