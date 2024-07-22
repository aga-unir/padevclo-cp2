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

