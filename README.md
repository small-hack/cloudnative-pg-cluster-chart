# CloudNativePG Tenant Chart

This [chart](https://small-hack.github.io/cloudnative-pg-tenant-chart/) is the tenant component to the operator component [here](https://github.com/cloudnative-pg/charts).

## TLDR

```bash
# add the helm repo locally
helm repo add cnpg https://small-hack.github.io/cloudnative-pg-tenant-chart

# get the values and edit them if needed
helm show values cnpg/cnpg-tenant > values.yaml

# install the chart
helm install cnpg cnpg/cnpg-tenant --values values.yaml
```
