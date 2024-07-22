# padevclo-cp2

## Quick Reference: Terraform

```
  az login --use-device-code
```

```
  terraform init
```

```
  terraform plan
```

```
  terraform apply
```

```
  terraform destroy
```

```
  skopeo copy docker://docker.io/nginx:latest docker://agadevops.azurecr.io/nginx:casopractico2
  skopeo copy docker://mcr.microsoft.com/azuredocs/azure-vote-front:v1 docker://agadevops.azurecr.io/aks/azure-vote-front:casopractico2
  skopeo copy docker://mcr.microsoft.com/oss/bitnami/redis:6.0.8 docker://agadevops.azurecr.io/aks/redis:casopractico2
```

[Terraform Doc](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

## Quick Reference: SSH

```
  ssh-keygen -t rsa
```

```
  ssh -i ~/.ssh/id_rsa_azcp2 adminuser@<public_ip>
```

## Quick Reference: Ansible

```
  ansible-vault encrypt_string 'acr_admin_password' --name 'acr_admin_password'
```

```
  
```

## Quick Reference: K8S

```
  kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
```
Error:
```
  kubectl create secret docker-registry regcred --docker-server=agadevops.azurecr.io --docker-username=agadevops --docker-password=<your-pword> --docker-email=<your-email>
    > error: failed to create secret Post "https://kubernetes.docker.internal:6443/api/v1/namespaces/default/secrets?fieldManager=kubectl-create&fieldValidation=Strict": dial tcp 127.0.0.1:6443: connect: connection refused
```
