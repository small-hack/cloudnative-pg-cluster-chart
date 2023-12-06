# CloudNativePG Cluster Chart

This [helm chart](https://small-hack.github.io/cloudnative-pg-tenant-chart/) is intended to be the Cluster helm chart component to the [CloudNativePG operator helm chart](https://github.com/cloudnative-pg/charts).

Docs autogeneratated from the [values.yaml](charts/cloudnative-pg-cluster/values.yaml) are slowly being put together in the chart directory's [README.md](./charts/cloudnative-pg-cluster/README.md).

## TLDR

```bash
# add the helm repo locally
helm repo add cnpg https://small-hack.github.io/cloudnative-pg-cluster-chart

# get the values and edit them if needed
helm show values cnpg/cnpg-cluster > values.yaml

# install the chart
helm install cnpg cnpg/cnpg-cluster --values values.yaml
```
