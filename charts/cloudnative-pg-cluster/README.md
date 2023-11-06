# cnpg-cluster

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Create postgres tenant clusters managed by the CNPG Operator

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| cloudymax |  | <https://github.com/cloudymax> |
| jessebot |  | <https://github.com/jessebot> |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backup.barmanObjectStore.destinationPath | string | `"backups"` |  |
| backup.barmanObjectStore.s3Credentials.accessKeyId.key | string | `"ACCESS_KEY_ID"` | key in Kubernetes Secret to use for S3 access key ID |
| backup.barmanObjectStore.s3Credentials.accessKeyId.name | string | `"aws-creds"` | existing Kubernetes Secret to use for S3 access key ID |
| backup.barmanObjectStore.s3Credentials.secretAccessKey.key | string | `"ACCESS_SECRET_KEY"` | key in Kubernetes Secret to use for S3 secret key |
| backup.barmanObjectStore.s3Credentials.secretAccessKey.name | string | `"aws-creds"` | existing Kubernetes Secret to use for S3 secret key |
| backup.retentionPolicy | string | `"30d"` | how long to keep backups for |
| bootstrap.initdb.database | string | `"app"` | initial database to create |
| bootstrap.initdb.owner | string | `"app"` | owner of the initial database that is created above |
| bootstrap.initdb.secret.name | string | `"app-secret"` |  |
| certificates.client.clientCASecret | string | `""` | name of existing Kubernetes Secret for the postgresql client Certificate Authority cert, ignored if certificates.generate is true |
| certificates.client.enabled | bool | `true` | enable using client certificates |
| certificates.client.generate | bool | `true` | generate client certs using cert-manager. if true the following are ignored: certificates.clientCASecret, certificates.replicationTLSSecret |
| certificates.client.replicationTLSSecret | string | `""` | name of existing Kubernetes Secret for the postgresql replication TLS cert ignored if certificates.generate is true |
| certificates.server.enabled | bool | `false` | enable using server certificates |
| certificates.server.generate | bool | `false` | generate server certs using cert-manager. if true the following are ignored: certificates.serverTLSSecret, certificates.serverCASecret |
| certificates.server.serverCASecret | string | `""` | name of existing Kubernetes Secret for the postgresql server Certificate Authority cert, ignored if certificates.generate is true |
| certificates.server.serverTLSSecret | string | `""` | name of existing Kubernetes Secret for the postgresql server TLS cert, ignored if certificates.generate is true |
| certificates.user.enabled | bool | `false` | create a certificate for a user to connect to postgres using CertManager requires server and client certificate generation enabled |
| certificates.user.username | string | `"app"` | name of the user to create a cert for, eg: the DbOwner specified earlier. This data populated into the commonName field of the certificate. |
| instances | int | `3` |  |
| monitoring.enablePodMonitor | bool | `false` | enable monitoring via Prometheus |
| name | string | `"cnpg"` |  |
| postgresql.pg_hba | list | `["hostnossl all all 0.0.0.0/0 reject","hostssl all all 0.0.0.0/0 cert clientcert=verify-full"]` | records for the pg_hba.conf file. ref: https://www.postgresql.org/docs/current/auth-pg-hba-conf.html |
| scheduledBackup.name | string | `"example-backup"` | name to use for your scheduled backup job |
| scheduledBackup.spec.backupOwnerReference | string | `"self"` |  |
| scheduledBackup.spec.cluster.name | string | `"pg-backup"` |  |
| scheduledBackup.spec.schedule | string | `"0 0 0 * * *"` | crontab style schedule to run the backups |
| storage.size | string | `"1Gi"` | how much storage to allocate to the postgresql cluster |
| superuserSecret.name | string | `"superuser-secret"` |  |
| testApp.enabled | bool | `false` |  |
| testApp.namespace | string | `"default"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)