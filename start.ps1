. .\functions.ps1

Import-DotEnv-Value -Path ".\.env"


k3d cluster delete $CLUSTER_NAME
k3d cluster create $CLUSTER_NAME   -p "80:80@loadbalancer"

k3d kubeconfig get $CLUSTER_NAME > $CLUSTER_CONFIG

helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab gitlab/gitlab --create-namespace --namespace gitlab  --kubeconfig $CLUSTER_CONFIG -f ./confs/values.yaml --timeout 800s

kubectl config use-context k3d-$CLUSTER_NAME

kubectl apply -f ./ingress