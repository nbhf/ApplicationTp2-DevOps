{{/*
Expand the name of the chart.
*/}}
{{- define "app-tp2.name" -}}
{{ .Chart.Name }}
{{- end -}}

{{/*
Create a fullname using the release name and chart name.
*/}}
{{- define "app-tp2.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels used across resources
*/}}
{{- define "app-tp2.labels" -}}
app.kubernetes.io/name: {{ include "app-tp2.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
