# AWSHIFT

## Who is who

quaktuss : Mathieu

0xs4yk : Maxence

kholius : Evan

![Roadmap](imgs/roadmap-conteneurisation.png)

## ChaosMonkey

First, Deploy Spinnaker
```
chmod +x hal-init.sh

docker compose -f docker-compose.hal.yml run -d
```

KUBECONFIG=/home/spinnaker/.kube/config kubectl config current-context

export KUBECONFIG=/home/spinnaker/.kube/config

hal config deploy edit --type distributed --account-name default


hal config storage s3 edit \
    --access-key-id <access-key-id> \
    --secret-access-key \
    --region eu-west-3

hal config storage edit --type s3


hal version list
hal config version edit --version 1.35.5

cp -r /home/spinnaker/.kube /root/.kube/
cp /home/spinnaker/.kube/config /root/.kube/config

3. then edit /home/spinnaker/.hal/config and set kubernetes.kubeconfigFile to /home/spinnaker/.kube/config

hal deploy apply

hal deploy connect


kubectl patch svc spin-deck -n spinnaker --patch '{"spec":{"type":"NodePort"}}'