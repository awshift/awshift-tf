# ------------------------------- #
#           K8s Cluster 
# ------------------------------- #


[rke:children]
master
worker

[master]
${master_ips}


[worker]
${worker_ips}

