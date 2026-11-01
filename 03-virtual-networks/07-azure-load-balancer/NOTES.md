# Comprehensive Summary: Introduction to Azure Load Balancer

## Module 1: Introduction to Azure Load Balancer
- **Overview**: Understanding how Azure Load Balancer distributes incoming network traffic across multiple backend virtual machines or services to ensure high availability and reliability.
- **Core Purpose**: Acting as the single point of contact for clients, distributing traffic efficiently at layer 4 (Transport layer).

---

## Module 2: What is Azure Load Balancer?
- **Definition**: A high-performance, ultra-low latency Layer 4 load balancer supporting TCP and UDP protocols.
- **SKU Options**:
  - **Basic Load Balancer**: Designed for small-scale applications; lacks advanced security and scaling features (deprecated for production).
  - **Standard Load Balancer**: Enterprise-grade load balancer supporting larger scales, secure default posture (implicit outbound rules), and integration with Availability Zones.
- **Key Components**: Frontend IP configuration, backend pool, health probes, and load-balancing rules.

---

## Module 3: How Azure Load Balancer Works
- **Routing Mechanism**: Operates on a 5-tuple hash (Source IP, Source Port, Destination IP, Destination Port, Protocol) to map traffic to backend instances.
- **Health Probes**: 
  - Periodically test the status of backend endpoints.
  - If a VM fails a health probe response, the load balancer stops sending new traffic to it until it recovers.
- **High Availability (HA) Ports**: 
  - Configured with protocol "All" and port "0".
  - Enables a single rule to load balance all TCP and UDP flows across all ports of an internal standard load balancer, commonly used for Network Virtual Appliances (NVAs).

---

## Module 4: When to Use Azure Load Balancer?
- **Primary Scenarios**:
  - Balancing inbound TCP and UDP traffic across VMs.
  - Supporting internal and external traffic distribution.
  - Achieving high availability for Network Virtual Appliances (NVAs) using HA Ports.
- **Distinction from Application Gateway**:
  - Use **Load Balancer** for Layer 4 (TCP/UDP) performance and raw throughput.
  - Use **Application Gateway** for Layer 7 (HTTP/HTTPS) web traffic routing, URL path-based routing, and WAF security.

---

## Module 5: Knowledge Check
- **Core Review Concepts**:
  - Identifying OSI Layer 4 as the operating layer for Azure Load Balancer.
  - Understanding how health probes maintain application uptime by removing unhealthy backends.
  - Recognizing the role of the 5-tuple hashing algorithm in maintaining session consistency.

---

## Module 6: Summary and Resources
- **Key Takeaways**:
  - Azure Load Balancer provides low-latency, high-capacity Layer 4 load balancing for cloud workloads.
  - Proper configuration of health probes and load balancing rules ensures resilience and fault tolerance.
- **Further Reading**: Official Microsoft documentation on Azure Load Balancer architectures, Standard SKU guidelines, and HA ports configuration.