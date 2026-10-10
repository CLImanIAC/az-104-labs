# Azure Identity & Governance: Microsoft Entra ID Fundamentals

## 1. Microsoft Entra ID vs. Traditional AD DS
* **Architecture & Protocols:**
  * **AD DS (On-Premises):** Relies on traditional protocols like **Kerberos, LDAP, and DNS**. Features a hierarchical structure (Forest, Domain, OUs) with physical Domain Controllers (DCs).
  * **Microsoft Entra ID (Cloud):** Built on modern web protocols and APIs, including **HTTPS, REST APIs, OAuth 2.0, OpenID Connect (OIDC), and SAML**. Uses a flat structure (no traditional OUs or classic GPOs).
* **Primary Purpose:** Cloud-based Identity and Access Management (IAM) service for cloud apps (Microsoft 365, Azure Portal, SaaS apps like GitHub, Salesforce).

---

## 2. Microsoft Entra ID Editions (Free vs. P1 vs. P2)
* **Free:** Basic user/group management, directory synchronization with on-prem AD, basic reports, and SSO (up to 10 apps per user).
* **P1 (Premium 1):** Focuses on **hybrid identity and advanced access control**. Includes **Conditional Access** policies (based on location, device state, risk), dynamic groups, and self-service password reset (SSPR) with on-premises write-back.
* **P2 (Premium 2):** Focuses on **identity protection and governance**. Includes **Microsoft Entra Identity Protection** (risk-based detection and automated remediation) and **Privileged Identity Management (PIM)** (Just-In-Time access for administrative roles).

---

## 3. Microsoft Entra Domain Services (AAD DS)
* **Definition:** Fully managed domain controllers (DCs) in the Azure cloud, eliminating the need to deploy, configure, and patch VM-based DCs.
* **Use Cases:** Running legacy applications in the cloud that require traditional **Kerberos/NTLM authentication**, LDAP queries, or domain-joined virtual machines where classic Group Policies (GPOs) are still mandatory.