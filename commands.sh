resource_group_name=$(terraform output -raw resource_group_name)
az aks list --resource-group $resource_group_name --query "[].{\"K8s cluster name\":name}" --output table
echo "$(terraform output kube_config)" > ./azurek8s
cat ./azurek8s
export KUBECONFIG=./azurek8s
kubectl get nodes
kubectl apply -f aks-store-quickstart.yaml
kubectl get pods
kubectl get service store-front --watch
