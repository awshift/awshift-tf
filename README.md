# AWSHIFT - M2INFRACLOUD

## Who is who

quaktuss : Mathieu

0xs4yk : Maxence

kholius : Evan

## Road Map
![Roadmap](imgs/roadmap-conteneurisation.png)

## Create EKS Cluster
### Prerequisites
- awscli
- kubectl
- eksctl

### Install eksctl
```bash
curl -LO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname | tr '[:upper:]' '[:lower:]')_amd64.tar.gz" 
 
tar -xzf eksctl_*_amd64.tar.gz 
 
sudo mv eksctl /usr/local/bin/ 
 
eksctl version 
```

### Create the cluster
On the project root path, run : 
```bash
eksctl create cluster -f eks-cluster.yaml 
```

### Delete the cluster
```bash
eksctl delete cluster --name <my-cluster> --region <region-code>
```