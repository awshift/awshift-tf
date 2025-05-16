## Install Chaos Mesh using Helm

### 1. Add Chaos Mesh repository
```bash 
helm repo add chaos-mesh https://charts.chaos-mesh.org
```

### 2. Create the namespace to install Chaos Mesh
```bash
kubectl create ns chaos-mesh
```

### 3. Install Chaos Mesh
```bash
helm install chaos-mesh chaos-mesh/chaos-mesh -n=chaos-mesh --set chaosDaemon.runtime=containerd --set chaosDaemon.socketPath=/run/containerd/containerd.sock --version 2.7.1
```

### 4. Verify the installation
```bash
kubectl get po -n chaos-mesh
```

## Configure Chaos Mesh

### Generate RBAC Token

Use the YAML file on awshift-tf/chaos/rbac.yaml

Run the following command
```bash
kubectl apply -f rbac.yaml
```

Get the token 
```bash
kubectl create token account-cluster-manager
```