# Summary: Describe Core Architectural Components of Azure

## 1. Introduction
* **Goal:** Understand the core physical and management structure of the Microsoft Azure platform.
* **Key Concepts:** Physical infrastructure (datacenters, regions, availability zones) and management infrastructure (resources, resource groups, subscriptions, management groups).

---

## 2. What is Microsoft Azure?
* **Definition:** Azure is a growing set of cloud services designed to help organizations meet their business challenges.
* **Operating Model:** Enables building, managing, and deploying applications on a massive global network using preferred tools and frameworks.
* **Benefits:** Agility, scalability, flexibility, and transitioning from CapEx to OpEx financial models.

---

## 3. Get Started with Azure Accounts
* **Azure Tenant / Entra ID:** The central identity environment associated with an organization.
* **Azure Account:** A user identity that provides access to Azure services and serves as the baseline for creating subscriptions.
* **Account Options:**
  * **Free Account:** Free credits for the first 30 days + access to select free services for 12 months + 55+ always-free services.
  * **Pay-As-You-Go:** Pay for what you use with no upfront commitments.
  * **Student / Enterprise Agreements (EA):** Customized agreements and discounts tailored for specific groups or enterprise organizations.

---

## 4. Describe Azure Physical Infrastructure
* **Datacenters:** Physical buildings containing servers, power, cooling, and networking equipment.
* **Regions:**
  * Geographical areas containing one or more datacenters connected via a low-latency network.
  * Ensure flexibility, compliance with local data residency laws, and proximity to users.
  * **Region Pairs:** Most regions are paired with another region within the same geography (at least 300 miles away) to protect against natural disasters and planned maintenance.
* **Availability Zones:**
  * Physically separate datacenters within the same Azure region.
  * Each zone has independent power, cooling, and networking.
  * Used to achieve **High Availability** and resilience against facility-level failures (SLA up to 99.99%).

---

## 5. Describe Azure Management Infrastructure
* **Resources:** The basic building blocks of Azure (Compute VMs, Storage Accounts, Virtual Networks, Databases).
* **Resource Groups:**
  * Logical containers that group resources sharing the same lifecycle (create, update, delete).
  * Each resource can belong to **only one** resource group at a time.
* **Subscriptions:**
  * A unit of management, security, and billing.
  * Connects Azure accounts to resources and defines boundaries for cost control and Role-Based Access Control (RBAC).
* **Management Groups:**
  * Hierarchical structures positioned above subscriptions.
  * Enable the application of governance policies (Azure Policy), compliance standards, and access controls (RBAC) across multiple subscriptions simultaneously.
  * **Hierarchy:** Root Management Group -> Management Groups -> Subscriptions -> Resource Groups -> Resources.

---

## 6. Knowledge Check & Summary
* **Key Takeaways:**
  1. Physical structure (Datacenters -> Availability Zones -> Regions) ensures resilience and high availability.
  2. Management structure (Management Groups -> Subscriptions -> Resource Groups -> Resources) provides strict governance, cost management, and access control.
  3. Mastering these core components forms the foundation for building any scalable and secure enterprise cloud architecture.