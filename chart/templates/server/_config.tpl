{{- define "unitycatalog.server.configTemplate" -}}
server.env=prod
server.authorization={{ .Values.auth.enabled | ternary "enable" "disable" }}
server.authorization-url={{ .Values.auth.authorizationUrl }}
server.token-url={{ .Values.auth.tokenUrl }}
server.client-id={{ .Values.auth.enabled | ternary "${OAUTH_CLIENT_ID}" "" }}
server.client-secret={{ .Values.auth.enabled | ternary "${OAUTH_CLIENT_SECRET}" "" }}
server.redirect-port={{ .Values.auth.redirectPort }}
# D-Days H-Hours M-Minutes S-Seconds (P5D = 5 days,PT5H = 5 hours, PT5M = 5 minutes, PT5S = 5 seconds)
server.cookie-timeout={{ .Values.auth.cookieTimeout }}

storage-root.models={{ .Values.storage.modelStorageRoot | default "file:/tmp/ucroot" }}

{{ range $index, $config := .Values.storage.credentials.s3 }}
s3.bucketPath.{{ $index }}={{ $config.bucketPath }}
s3.region.{{ $index }}={{ $config.region }}
s3.awsRoleArn.{{ $index }}={{ $config.awsRoleArn }}
s3.accessKey.{{ $index }}=${S3_ACCESS_KEY_{{ $index }}}
s3.secretKey.{{ $index }}=${S3_SECRET_KEY_{{ $index }}}
{{ end }}

{{ range $index, $config := .Values.storage.credentials.adls }}
adls.storageAccountName.{{ $index }}={{ $config.storageAccountName }}
adls.tenantId.{{ $index }}=${ADLS_TENANT_ID_{{ $index }}}
adls.clientId.{{ $index }}=${ADLS_CLIENT_ID_{{ $index }}}
adls.clientSecret.{{ $index }}=${ADLS_CLIENT_SECRET_{{ $index }}}
{{ end }}

{{ range $index, $config := .Values.storage.credentials.gcs }}
gcs.bucketPath.{{ $index }}={{ $config.bucketPath }}
gcs.jsonKeyFilePath.{{ $index }}=/etc/conf/gcs-credentials-{{ $index }}.json
{{ end }}

{{- end }}
