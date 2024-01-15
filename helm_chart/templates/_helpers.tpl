# chart/_helpers.tpl


{{- define "chart.labels" -}}
app.kubernetes.io/name: {{ include "chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end -}}

{{- define "chart.selectorLabels" -}}
{{- include "chart.labels" . | nindent 4 }}
{{- end -}}

{{- define "chart.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}