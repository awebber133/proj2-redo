{{- define "proj2.name" -}}
proj2
{{- end }}

{{- define "proj2.fullname" -}}
{{ include "proj2.name" . }}
{{- end }}
