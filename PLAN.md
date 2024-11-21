
# Projet AWS + OpenShift

## Équipe
- **Evan Verite**
- **Mathieu Pheron**
- **Maxence Lancosme**

## Pitch
Mise en place d'une infrastructure AWS automatisée à l'aide de Terraform, capable d'accueillir une instance OpenShift de base.  
Le déploiement et la gestion de cette solution seront orchestrés via une pipeline GitOps.

---

## Étapes du Projet

### **Étape 1 : Infrastructure (IaaS)**  
Mise en place d'une infrastructure complète sur AWS :  
- **Réseau** : gestion des VPC, sous-réseaux, pare-feu (security groups).  
- **Compute** : provisionnement des instances EC2 et auto-scaling groups.  
- **Stockage** : configuration des volumes EBS, S3, et snapshots pour les backups.  
- **DNS & Certificats** : gestion avec Route 53 et ACM (AWS Certificate Manager).  
- **Load Balancer / API Gateway** : distribution du trafic et gestion des endpoints API.  

---

### **Étape 2 : Plateforme (PaaS)**  
Mise en place d'OpenShift :  
1. Installation de base : cycle manuel pour validation.  
2. Automatisation : script d'installation et configuration pour répétabilité.

---

### **Étape 3 : Services (SaaS)**  
Ajout d'une couche GitOps pour le déploiement et la gestion :  
- **Analyse de code** : pipelines CI (intégration continue).  
- **Gestion des releases** : système de publication, suivi des versions et possibilité de rollback.  
- **Bonus (FinOps)** : mise en place d'outils ou stratégies pour optimiser les coûts d'infrastructure.

---

## Objectif Final
Créer une infrastructure robuste, scalable et entièrement automatisée, tout en intégrant les bonnes pratiques DevOps et FinOps.
