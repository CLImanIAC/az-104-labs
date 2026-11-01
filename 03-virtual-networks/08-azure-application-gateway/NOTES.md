# MS Learn: Introduction to Azure Application Gateway - Summary

## 1. Introduction & Overview
- **Core Purpose:** Azure Application Gateway is a web traffic (OSI Layer 7) load balancer that manages HTTP/HTTPS traffic to web applications.
- **Key Advantage:** Unlike Layer 4 load balancers that route based on IP and port, Application Gateway inspects the actual web request content.

---

## 2. What is Azure Application Gateway?
- **Definition:** A dedicated web traffic load balancer as a Service (PaaS).
- **Supported Backends:** 
  - Azure Virtual Machines (VMs)
  - Virtual Machine Scale Sets (VMSS)
  - Azure App Service
  - On-premises servers (via hybrid connections / ExpressRoute)

---

## 3. How Azure Application Gateway Works
- **URL-Based Routing:** Routes incoming client requests to different backend pools based on the URL path (e.g., `/images/*` goes to one pool, `/video/*` to another).
- **SSL/TLS Termination & End-to-End Encryption:** Handles incoming SSL certificates at the gateway and can re-encrypt traffic toward the backend servers.
- **Web Application Firewall (WAF):** Protects web apps from common web vulnerabilities (like SQL injection and cross-site scripting) using OWASP core rule sets.
- **Autoscaling & High Availability:** Automatically scales capacity based on traffic load and spans across fault domains.

---

## 4. When to Use Azure Application Gateway
- **Ideal Scenarios:**
  - Web applications requiring Layer 7 load balancing (cookie-based session affinity, path-based routing).
  - Enhancing security with a built-in WAF.
  - Offloading SSL/TLS decryption overhead from backend web servers.
- **Contrast:** Used for web traffic (HTTP/S), whereas Azure Load Balancer handles TCP/UDP transport layer workloads, and Azure Front Door handles global/edge multi-region content routing.

---

## 5. Summary & Key Takeaways
- Application Gateway simplifies web architecture by combining load balancing, WAF, and secure routing into a single managed service.
- Supports flexible backend targets across cloud and on-premises environments.
- Ensures robust security via encryption options (client-to-gateway and gateway-to-backend) and central policy enforcement.