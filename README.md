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

Certificates are generated using [CertManager](https://cert-manager.io/) to bootstrap self-signed CAs, Issuers and certs. To use them, please provide the following via your helm `values.yaml`:

```yaml
# -- name to use for templating certs
name: "app-postgres"

certificates:
  server:
    # -- enable using server certificates
    enabled: true
    # -- generate server certs using cert-manager. if true the following
    # are ignored: certificates.serverTLSSecret, certificates.serverCASecret
    generate: true
    # -- name of existing Kubernetes Secret for the postgresql server TLS cert,
    # ignored if certificates.generate is true
    serverTLSSecret: ""
    # -- name of existing Kubernetes Secret for the postgresql server Certificate
    # Authority cert, ignored if certificates.generate is true
    serverCASecret: ""
  client:
    # -- enable using client certificates
    enabled: true
    # -- generate client certs using cert-manager. if true the following are
    # ignored: certificates.clientCASecret, certificates.replicationTLSSecret
    generate: true
    # -- name of existing Kubernetes Secret for the postgresql client Certificate
    # Authority cert, ignored if certificates.generate is true
    clientCASecret: ""
    # -- name of existing Kubernetes Secret for the postgresql replication TLS
    # cert ignored if certificates.generate is true
    replicationTLSSecret: ""
  user:
    # -- create a certificate for a user to connect to postgres using CertManager
    # requires server and client certificate generation enabled
    enabled: true
    # -- List of names of users to create a cert for, eg: the DbOwner specified earlier.
    # This data populated into the commonName field of the certificate.
    username:
      - "my-app"
```

Then, if you're using our bundled upstream CNPG cluster chart, make sure you provide the following:

```yaml
cnpgCluster:
  # -- enable this to deploy the official CNPG cluster helm chart dep
  # All other values here are passed directly to the their chart. See:
  # https://github.com/cloudnative-pg/charts/blob/main/charts/cluster/values.yaml
  enabled: true
  # -- see: https://cloudnative-pg.io/docs/1.28/certificates#client-certificate
  certificates:
    ## examples if using our certificates features of this chart.
    ## NOTE: app-postgres should be replaced with whatever you set Values.name to
    serverTLSSecret: "app-postgres-server-cert"
    serverCASecret: "app-postgres-server-ca-key-pair"
    clientCASecret: "app-postgres-client-ca-key-pair"
    replicationTLSSecret: "app-postgres-client-cert"

  cluster:
    initdb:
      # -- replace this with your database name
      database: app
      # -- replace this with your database username
      owner: app

    postgresql:
      # -- records for the pg_hba.conf file. ref: https://www.postgresql.org/docs/current/auth-pg-hba-conf.html
      # this states that certs are required for access to the cluster,
      # but you can change it to still allow passwords if you'd like
      pg_hba:
        - hostnossl all all 0.0.0.0/0 reject
        - hostssl all all 0.0.0.0/0 cert clientcert=verify-full
```

### Using the test app

The test app may be enabled by certificates as well as setting `testApp.enabled=true` in your helm parameters or in the `values.yaml` like this:
```yaml
# -- name to use for templating certs
name: "app-postgres"

testApp:
  enabled: true
  # -- replace this with your database name
  database: app
  # -- replace this with your database username
  owner: app
```
This will create a very basic Deployment of `ghcr.io/cloudnative-pg/webtest` [as described in the official docs](https://cloudnative-pg.io/docs/1.28/ssl_connections#testing-the-connection-via-a-tls-certificate) that attempts to connect to your postgres cluster using full mTLS.
