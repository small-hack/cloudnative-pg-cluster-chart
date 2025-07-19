{{/*
Expand the name of the chart.
*/}}
{{- define "cnpg-tenant.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cnpg-tenant.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cnpg-tenant.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cnpg-tenant.labels" -}}
helm.sh/chart: {{ include "cnpg-tenant.chart" . }}
{{ include "cnpg-tenant.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cnpg-tenant.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cnpg-tenant.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cnpg-tenant.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cnpg-tenant.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Whether we need to use TimescaleDB defaults
*/}}
{{- define "cluster.useTimescaleDBDefaults" -}}
{{ and (eq .Values.type "timescaledb") .Values.imageCatalog.create (empty .Values.imageCatalog.images) }}
{{- end -}}

{{/*
Postgres UID
*/}}
{{- define "cluster.postgresUID" -}}
  {{- if ge (int .Values.postgresUID) 0 -}}
    {{- .Values.postgresUID }}
  {{- else if and (eq (include "cluster.useTimescaleDBDefaults" .) "true") (eq .Values.type "timescaledb") -}}
    {{- 1000 -}}
  {{- else -}}
    {{- 26 -}}
  {{- end -}}
{{- end -}}

{{/*
Postgres GID
*/}}
{{- define "cluster.postgresGID" -}}
  {{- if ge (int .Values.postgresGID) 0 -}}
    {{- .Values.postgresGID }}
  {{- else if and (eq (include "cluster.useTimescaleDBDefaults" .) "true") (eq .Values.type "timescaledb") -}}
    {{- 1000 -}}
  {{- else -}}
    {{- 26 -}}
  {{- end -}}
{{- end -}}
