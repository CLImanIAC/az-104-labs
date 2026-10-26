# Azure Virtual Network Security - Study Notes
---

## 1. Introduction & Overview
* **Objective:** Establish robust perimeter and internal network security for Azure Virtual Networks (VNets).
* **Core Principle:** Defense-in-Depth across infrastructure, transport, and application layers.

---

## 2. Threat Detection, Logging & Data Protection
* **Network Logging:**
  * **NSG Flow Logs / VNet Flow Logs:** Track IP traffic (source/destination IP, port, protocol, decision: Allow/Deny).
  * **Network Watcher:** Diagnostic tool for packet capture, IP flow verify, next hop analysis, and VPN troubleshooting.
* **Threat Detection:**
  * **Microsoft Defender for Cloud:** Continuous monitoring for exposed management ports, misconfigured NSGs, and anomalous network activity.
  * **Azure Sentinel / SIEM Integration:** Ingestion of network diagnostic logs for threat hunting and correlation.

---

## 3. Azure Virtual Network (VNet) Fundamentals
* **Isolation:** VNets provide isolated private IP address spaces ($10.0.0.0/8$, $172.16.0.0/12$, $192.168.0.0/16$).
* **Subnets:** Segmentation within a VNet.
  * **Dedicated Subnets:** `GatewaySubnet`, `AzureFirewallSubnet`, `AzureBastionSubnet`.
  * **GatewaySubnet Restriction:** *Never* attach UDRs containing $0.0.0.0/0$ or disable route propagation, as it breaks control plane operations.

---

## 4. Azure Virtual Network Manager (AVNM)
* **Function:** Centralized management of VNets across subscriptions, regions, and resource groups.
* **Network Groups:** Logical grouping of VNets (dynamically using Azure Policy or statically).
* **Security Admin Rules:** High-priority security rules enforced globally that take precedence over local NSGs.
* **Topologies:** Automated creation of Mesh or Hub-and-Spoke connectivity configurations.

---

## 5. NSGs (Network Security Groups) & ASGs (Application Security Groups)
* **NSG (Filtering - Allow/Deny):**
  * Operates at Layer 4 (TCP/UDP/ICMP).
  * Associated with **Subnets** or individual **NICs** (Subnet evaluation occurs first for inbound traffic; NIC evaluation occurs first for outbound traffic).
  * **Default Rules:** Allow VNet Inbound, Allow Load Balancer Inbound, Deny All Inbound.
* **ASG (Grouping):**
  * Groups VMs logically using labels (e.g., `ASG-Web`, `ASG-DB`).
  * Used as source/destination in NSG rules to eliminate hardcoded IP management.

---

## 6. User-Defined Routes (UDR) & Custom Routing
* **UDR (Traffic Steering - Next Hop):** Overrides default system routes.
* **Evaluation Algorithm:** **Longest Prefix Match (LPM)** determines the route path.
  * *Priority:* User-Defined Routes (UDR) > BGP Routes > System Routes.
* **Next Hop Types:**
  * `VirtualAppliance`: Preconfigured VM/Firewall (requires `Enable IP Forwarding` on Azure NIC and OS level).
  * `VirtualNetworkGateway`: Routes to VPN/ExpressRoute gateway.
  * `VNetLocal`: Keeps traffic internal to the VNet.
  * `Internet`: Routes directly to the internet via Azure backbone.
  * `None`: Drops traffic (Blackhole).
* **Service Tags in UDR:** Priority sequence: Regional Specific > Top-Level Service Tag > AzureCloud Regional > AzureCloud.

---

## 7. VNet Peering & Gateways
* **VNet Peering:**
  * Direct private routing over Microsoft backbone with low latency and high bandwidth.
  * Regional or Global Peering.
  * **Transitivity:** Non-transitive by default (VNet A peerd to VNet B, and VNet B peerd to VNet C does NOT allow A $\leftrightarrow$ C communication without an intermediate NVA/Router).
* **Gateway Transit:** Allows Spoke VNets to utilize a shared VPN/ExpressRoute Gateway located in a Hub VNet.

---

## 8. Azure Virtual WAN (vWAN)
* **Function:** Enterprise-scale network architecture for large-scale branch-to-cloud and cloud-to-cloud connectivity.
* **Hub-and-Spoke Automation:** Managed Virtual Hubs hosted in Microsoft-managed VNets.
* **Secured Virtual Hub:** Integrated Azure Firewall, Third-Party NVAs, and security policies managed directly within the vWAN hub.

---

## 9. Hybrid Private VPN Connectivity (P2S & S2S)
* **Point-to-Site (P2S):** Individual clients connecting to VNet (SSTP, OpenVPN, IKEv2).
* **Site-to-Site (S2S):** Cross-premises connectivity using IPsec/IKE tunnels over the public internet.
* **BGP Integration:** Automatic route propagation between on-prem routers and Azure Virtual Network Gateways.

---

## 10 & 11. Azure Encryption & VNet Encryption
* **Encryption in Transit:** TLS for web endpoints, IPsec/IKE for VPNs, MACsec for ExpressRoute.
* **Azure VNet Encryption:**
  * Native underlying encryption at line-rate for traffic between Virtual Machines within the same VNet or peered VNets.
  * Operates at Datalink/Network layer without performance overhead or CPU strain on VMs.

---

## 12 & 13. Azure ExpressRoute & Encryption
* **ExpressRoute:** Dedicated private connection via telecommunications provider (bypasses public internet).
* **Key Features:** SLA guarantees, deterministic latency, speeds up to 100 Gbps.
* **BGP Requirement:** Mandatory BGP routing for route exchanges.
* **ExpressRoute Encryption:**
  * **MACsec (Layer 2):** Encrypts traffic at line-rate between client edge routers and Microsoft edge routers.
  * **IPsec over ExpressRoute (Layer 3):** Encrypted VPN tunnel over private ExpressRoute circuit for double protection.

---

## 14. Network Security Best Practices
1. **Adopt Hub-and-Spoke Topology:** Centralize ingress/egress filtering via NVA/Azure Firewall.
2. **Zero Trust & Micro-segmentation:** Enforce tight NSGs, ASGs, and deny-by-default rules.
3. **Protect GatewaySubnet:** Keep `GatewaySubnet` isolated from $0.0.0.0/0$ UDRs.
4. **Disable Direct Public IPs:** Access workloads via Bastion, VPN, or Private Endpoints.
5. **Enforce Forced Tunneling:** Route all egress internet traffic to NVA/On-prem for inspection.

---

## 15. Monitoring Network Security
* **Network Watcher Diagnostics:**
  * **IP Flow Verify:** Test if NSG is blocking specific traffic.
  * **Next Hop:** Verify routing decision and path.
  * **Connection Troubleshoot:** Test end-to-end TCP connectivity.
* **Traffic Analytics:** Visualizes flow log data to spot malicious activity, top talkers, and unexpected outbound connections.

---

## 16 & 17. Summary & Core Takeaways
* Security requires pairing **filtering** (NSG/ASG) with **routing** (UDR/BGP) and **encryption** (VNet Encryption/MACsec).
* Proper network design prevents unauthorized lateral movement, data exfiltration, and management plane compromise in hybrid environments.