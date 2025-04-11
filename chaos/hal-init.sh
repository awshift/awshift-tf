#!/bin/bash

sleep 5

chown spinnaker:spinnaker /home/spinnaker/.hal

hal config provider kubernetes enable

CONTEXT=$(kubectl config current-context)

hal config provider kubernetes account add default \
  --context $CONTEXT

hal config features edit --artifacts-rewrite true

# Keep container alive
tail -f /dev/null