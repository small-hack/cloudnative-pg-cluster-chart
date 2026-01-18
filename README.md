# CloudNativePG Cluster Chart

This [helm chart](https://small-hack.github.io/cloudnative-pg-tenant-chart/) was intended to be the Cluster helm chart component to the [CloudNativePG operator helm chart](https://github.com/cloudnative-pg/charts/tree/main/charts/cloudnative-pg), but now serves mostly as a wrapper for their official [CloudNativePG cluster helm chart](https://github.com/cloudnative-pg/charts/tree/main/charts/cluster) that provides certificate and test app functionality.

Docs auto-generated from the [values.yaml](charts/cloudnative-pg-cluster/values.yaml) are available in the chart directory's [README.md](./charts/cloudnative-pg-cluster/README.md).

## TLDR

```bash
# add the helm repo locally
helm repo add cnpg-wrapper https://small-hack.github.io/cloudnative-pg-cluster-chart

# get the values and edit them if needed
helm show values cnpg-wrapper/cnpg-cluster > values.yaml

# install the chart
helm install cnpg cnpg-wrapper/cnpg-cluster --values values.yaml
```

## Notes

### Using the certficates

### Using the test app
