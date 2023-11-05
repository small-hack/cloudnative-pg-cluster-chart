# CloudNativePG Tenant Chart

This [helm chart](https://small-hack.github.io/cloudnative-pg-tenant-chart/) is the tenant component to the [CloudNativePG operator helm chart](https://github.com/cloudnative-pg/charts). Docs autogeneratated from the values.yaml are slowly being put togethere in the chart directory's [README.md](https://github.com/small-hack/cloudnative-pg-tenant-chart/tree/main/charts/cloudnative-pg-tenant#readme).

## TLDR

```bash
# add the helm repo locally
helm repo add cnpg https://small-hack.github.io/cloudnative-pg-tenant-chart

# get the values and edit them if needed
helm show values cnpg/cnpg-tenant > values.yaml

# install the chart
helm install cnpg cnpg/cnpg-tenant --values values.yaml
```
