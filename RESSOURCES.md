
# Projet AWS + OpenShift

---

## Ressources

- **Réseau** : 1 VPC, 3 subnets, 1 IGW ( +1 bonus), 1 LB (L7), SecurityGroups (NSEW)

- **Compute** : 

Admin Machine:

| Machine | Operating System | CPU  | RAM |
| --- | --- | --- | --- |
| Admin | CentOS | 1 | 2 |
| HTTP Server | CentOS | 1 | 2 |

Hardware Requirement:
Operating System: Fedora Core OS

| Machine | Operating System | CPU  | RAM | Number |
| --- | --- | --- | --- | -- |
| Bootstrap | FCOS | 4 | 16 GB | 1 | 
| Control plane | FCOS | 4 | 16 GB | 3 | 
| Compute | FCOS | 2 | 8 GB | 2+ | 

- **Stockage** :

| Machine | Operating System | Storage | IOPS |
| --- | --- |  --- | --- |
| Bootstrap | FCOS | 100GB | 300 |
| Control plane | FCOS | 100GB | 300 |
| Compute | FCOS |  100GB | 300 |

- **DNS & Certificats** : 

| Component | Record | Description |
| --- | --- | --- |
| Kube API | api.<cluster_name>.<base_domain>. | A DNS A/AAAA or CNAME record, and a DNS PTR record, to identify the API load balancer. These records must be resolvable by both clients external to the cluster and from all the nodes within the cluster. |
|  | api-int.<cluster_name>.<base_domain>. | A DNS A/AAAA or CNAME record, and a DNS PTR record, to internally identify the API load balancer. These records must be resolvable from all the nodes within the cluster. |
| Routes | *.apps.<cluster_name>.<base_domain>. | A wildcard DNS A/AAAA or CNAME record that refers to the application ingress load balancer. The application ingress load balancer targets the machines that run the Ingress Controller pods. The Ingress Controller pods run on the compute machines by default. These records must be resolvable by both clients external to the cluster and from all the nodes within the cluster.
| Bootstarp Machine | bootstrap.<cluster_name>.<base_domain>. | A DNS A/AAAA or CNAME record, and a DNS PTR record, to identify the bootstrap machine. These records must be resolvable by the nodes within the cluster. |
| Control plane Machines | <master><n>.<cluster_name>.<base_domain>. | DNS A/AAAA or CNAME records and DNS PTR records to identify each machine for the control plane nodes. These records must be resolvable by the nodes within the cluster. |
| Compute Machines | <worker><n>.<cluster_name>.<base_domain>. | DNS A/AAAA or CNAME records and DNS PTR records to identify each machine for the worker nodes. These records must be resolvable by the nodes within the cluster. |

--- 


Certificat Wildcard supporter par l'ALB