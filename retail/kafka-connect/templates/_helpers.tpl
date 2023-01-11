{{/*
Expand the name of the chart.
*/}}
{{- define "kafka-connect.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "kafka-connect.build.imageStream" -}}
{{- if .Values.build.imageStreamOverride }}
{{- .Values.build.imageStreamOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" $name "build" }}
{{- end }}
{{- end }}

{/*
Annotations
*/}}
{{- define "kafka-connect.annotations" -}}
strimzi.io/use-connector-resources: 'true'
{{- if .Values.argocd }}
{{- if and (.Values.argocd.syncwave) (.Values.argocd.enabled) }}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.syncwave }}"
{{- end }}
{{- end }}
{{- end }}

{/*
ArgoCD Syncwave
*/}}
{{- define "kafka-connect.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}
