# Helm Chart for Unity Catalog

![Apache-2.0 license](https://img.shields.io/github/license/sdwbgn/unitycatalog-helm)

Unity Catalog is a universal catalog for data and AI. It offers an open source solution designed to seamlessly integrate with various clouds, data formats, and data platforms.

## Introduction
This chart deploys [Unity Catalog](https://github.com/unitycatalog/unitycatalog) on a Kubernetes cluster 
using the [Helm](https://github.com/helm/helm) package manager.

## Prerequisites
- Kubernetes 1.20+ cluster
- Helm 3.0+

## Features
- Deploys Unity Catalog server and UI
- Supports OAuth authentication: Google, Okta, Keycloak
- Supports Unity Catalog versions: 0.2.1+

## Installing the Chart
To install the chart with the release name `unitycatalog`:

```sh
helm install unitycatalog oci://ghcr.io/sdwbgn/unitycatalog-helm/unitycatalog-helm:0.0.1
```

## Configuration
The following table lists the configurable parameters of the Unity Catalog chart and their default values.

| Parameter                                           | Description                                                                              | Default                                            | Example                                                                                                                                                                                                                |
|-----------------------------------------------------|------------------------------------------------------------------------------------------|----------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `storage.modelStorageRoot`                          | Root path for the model storage                                                          | `""`                                               | `s3://bucket/path`                                                                                                                                                                                                     |
| `storage.credentials.s3`                            | S3 credentials for accessing the storage                                                 | `[]`                                               | <pre>- bucketPath: s3://my-bucket-path<br>  region: us-east-1<br>  awsRoleArn: arn:aws:iam::123456789012:role/my-role<br>  credentialsSecretName: my-bucket-secret</pre>                                               |
| `storage.credentials.adls`                          | ADLS credentials for accessing the storage                                               | `[]`                                               | <pre>- storageAccountName: my-storage-account<br>  credentialsSecretName: my-storage-secret</pre>                                                                                                                      |
| `storage.credentials.gcs`                           | GCS credentials for accessing the storage                                                | `[]`                                               | <pre>- bucketPath: gs://my-bucket-name<br>  credentialsSecretName: my-bucket-secret</pre>                                                                                                                              |
| `auth.enabled`                                      | Enable OAuth authentication                                                              | `false`                                            | `true`                                                                                                                                                                                                                 |
| `auth.users`                                        | List of users to be created in the system                                                | `[]`                                               | <pre>- name: user<br>  email: user@example.com</pre>                                                                                                                                                                   |
| `auth.provider`                                     | OAuth provider<br>Currently supported options: `google`, `okta`, `keycloak`              | `google`                                           | `google`                                                                                                                                                                                                               |
| `auth.authorizationUrl`                             | OAuth authorization URL                                                                  | `""`                                               | `https://accounts.google.com/o/oauth2/auth`                                                                                                                                                                            |
| `auth.tokenUrl`                                     | OAuth token URL                                                                          | `""`                                               | `https://oauth2.googleapis.com/token`                                                                                                                                                                                  |
| `auth.clientSecretName`                             | OAuth client secret                                                                      | `""`                                               | `my-client-secret`                                                                                                                                                                                                     |
| `auth.redirectPort`                                 | OAuth redirect port                                                                      | `""`                                               | `8080`                                                                                                                                                                                                                 |
| `auth.cookieTimeout`                                | OAuth cookie timeout                                                                     | `P5D`                                              | `P5D`                                                                                                                                                                                                                  |
| `auth.oktaDomain`                                   | Okta domain                                                                              | `""`                                               | `example.okta.com`                                                                                                                                                                                                     |
| `auth.keycloakRealmId`                              | Keycloak realm ID                                                                        | `""`                                               | `my-realm`                                                                                                                                                                                                             |
| `db.type`                                           | Database type<br>Currently supported options: `file`                                     | `file`                                             | `file`                                                                                                                                                                                                                 |
| `db.fileConfig.persistence.enabled`                 | Enable persistence for the file database                                                 | `true`                                             | `false`                                                                                                                                                                                                                |
| `db.fileConfig.persistence.accessModes`             | Access modes for the file database                                                       | `[ "ReadWriteOnce" ]`                              | `[ "ReadWriteOnce" ]`                                                                                                                                                                                                  |
| `db.fileConfig.persistence.size`                    | Size of the file database                                                                | `1Gi`                                              | `1Gi`                                                                                                                                                                                                                  |
| `db.fileConfig.persistence.storageClassName`        | Storage class for the file database                                                      | `""`                                               | `""`                                                                                                                                                                                                                   |
| `server.config.persistence.enabled`                 | Enable persistence for the server configuration                                          | `true`                                             | `false`                                                                                                                                                                                                                |
| `server.config.persistence.accessModes`             | Access modes for the server configuration                                                | `[ "ReadWriteOnce" ]`                              | `[ "ReadWriteOnce" ]`                                                                                                                                                                                                  |
| `server.config.persistence.size`                    | Size of the server configuration                                                         | `100Mi`                                            | `100Mi`                                                                                                                                                                                                                |
| `server.config.persistence.storageClassName`        | Storage class for the server configuration                                               | `""`                                               | `""`                                                                                                                                                                                                                   |
| `server.service.type`                               | Service type for the server                                                              | `ClusterIP`                                        | `LoadBalancer`                                                                                                                                                                                                         |
| `server.service.port`                               | Service port for the server                                                              | `8080`                                             | `8080`                                                                                                                                                                                                                 |
| `server.statefulset.port`                           | Port for the server statefulset                                                          | `8080`                                             | `8080`                                                                                                                                                                                                                 |
| `server.statefulset.initContainer.image.repository` | Repository for the init container                                                        | `bhgedigital/envsubst`                             | `bhgedigital/envsubst`                                                                                                                                                                                                 |
| `server.statefulset.initContainer.image.pullPolicy` | Pull policy for the init container                                                       | `IfNotPresent`                                     | `IfNotPresent`                                                                                                                                                                                                         |
| `server.statefulset.initContainer.image.tag`        | Tag for the init container                                                               | `latest`                                           | `latest`                                                                                                                                                                                                               |
| `server.statefulset.image.repository`               | Repository for the server image                                                          | `ghcr.io/sdwbgn/unitycatalog-helm/unitycatalog`    | `unitycatalog/unitycatalog`                                                                                                                                                                                            |
| `server.statefulset.image.pullPolicy`               | Pull policy for the server image                                                         | `IfNotPresent`                                     | `IfNotPresent`                                                                                                                                                                                                         |
| `server.statefulset.image.tag`                      | Tag for the server image<br>If not specified, `appVersion` from chart/Chart.yaml is used | `""`                                               | `0.2.1`                                                                                                                                                                                                                |
| `server.statefulset.imagePullSecrets`               | Image pull secrets for the server                                                        | `[]`                                               | <pre>- name: my-secret</pre>                                                                                                                                                                                           |
| `server.statefulset.podAnnotations`                 | Annotations for the server pod                                                           | `{}`                                               | <pre>key1: value1</pre>                                                                                                                                                                                                |
| `server.statefulset.podLabels`                      | Labels for the server pod                                                                | `{}`                                               | <pre>key1: value1</pre>                                                                                                                                                                                                |
| `server.statefulset.podSecurityContext`             | Security context for the server pod                                                      | `{}`                                               | <pre>fsGroup: 101</pre>                                                                                                                                                                                                |
| `server.statefulset.securityContext`                | Security context for the server                                                          | `{}`                                               | <pre>runAsUser: 101</pre>                                                                                                                                                                                              |
| `server.statefulset.resources`                      | Resources for the server                                                                 | `{}`                                               | <pre>requests:<br>  memory: "64Mi"<br>  cpu: "250m"<br>limits:<br>  memory: "64Mi"<br>  cpu: "250m"</pre>                                                                                                              |
| `server.statefulset.livenessProbe.tcpSocket.port`   | Port for the server liveness probe                                                       | `api`                                              | `api`                                                                                                                                                                                                                  |
| `server.statefulset.readinessProbe.tcpSocket.port`  | Port for the server readiness probe                                                      | `api`                                              | `api`                                                                                                                                                                                                                  |
| `server.statefulset.volumes`                        | Volumes for the server                                                                   | `[]`                                               | <pre>- name: my-volume<br>  persistentVolumeClaim:<br>    claimName: my-claim</pre>                                                                                                                                    |
| `server.statefulset.volumeMounts`                   | Volume mounts for the server                                                             | `[]`                                               | <pre>- name: my-volume<br>  mountPath: /path</pre>                                                                                                                                                                     |
| `server.statefulset.nodeSelector`                   | Node selector for the server                                                             | `{}`                                               | <pre>key1: value1</pre>                                                                                                                                                                                                |
| `server.statefulset.tolerations`                    | Tolerations for the server                                                               | `[]`                                               | <pre>- key: "key1"<br>  operator: "Equal"<br>  value: "value1"<br>  effect: "NoSchedule"</pre>                                                                                                                         |
| `server.statefulset.affinity`                       | Affinity for the server                                                                  | `{}`                                               | <pre>nodeAffinity:<br>  requiredDuringSchedulingIgnoredDuringExecution:<br>    nodeSelectorTerms:<br>    - matchExpressions:<br>      - key: key1<br>        operator: In<br>        values:<br>        - value1</pre> |
| `server.createUsersJob.image.repository`            | Repository for the create users job image                                                | `badouralix/curl-jq`                               | `badouralix/curl-jq`                                                                                                                                                                                                   |
| `server.createUsersJob.image.pullPolicy`            | Pull policy for the create users job image                                               | `IfNotPresent`                                     | `IfNotPresent`                                                                                                                                                                                                         |
| `server.createUsersJob.image.tag`                   | Tag for the create users job image                                                       | `latest`                                           | `latest`                                                                                                                                                                                                               |
| `server.createUsersJob.imagePullSecrets`            | Image pull secrets for the create users job                                              | `[]`                                               | <pre>- name: my-secret</pre>                                                                                                                                                                                           |
| `ui.enabled`                                        | Enable the UI                                                                            | `true`                                             | `false`                                                                                                                                                                                                                |
| `ui.service.type`                                   | Service type for the UI                                                                  | `ClusterIP`                                        | `LoadBalancer`                                                                                                                                                                                                         |
| `ui.service.port`                                   | Service port for the UI                                                                  | `3000`                                             | `3000`                                                                                                                                                                                                                 |
| `ui.deployment.port`                                | Port for the UI deployment                                                               | `3000`                                             | `3000`                                                                                                                                                                                                                 |
| `ui.deployment.replicaCount`                        | Replica count for the UI deployment                                                      | `1`                                                | `1`                                                                                                                                                                                                                    |
| `ui.deployment.initContainer.image.repository`      | Repository for the init container                                                        | `busybox`                                          | `busybox`                                                                                                                                                                                                              |
| `ui.deployment.initContainer.image.pullPolicy`      | Pull policy for the init container                                                       | `IfNotPresent`                                     | `IfNotPresent`                                                                                                                                                                                                         |
| `ui.deployment.initContainer.image.tag`             | Tag for the init container                                                               | `latest`                                           | `latest`                                                                                                                                                                                                               |
| `ui.deployment.image.repository`                    | Repository for the UI image                                                              | `ghcr.io/sdwbgn/unitycatalog-helm/unitycatalog-ui` | `unitycatalog/unitycatalog-ui`                                                                                                                                                                                         |
| `ui.deployment.image.pullPolicy`                    | Pull policy for the UI image                                                             | `IfNotPresent`                                     | `IfNotPresent`                                                                                                                                                                                                         |
| `ui.deployment.image.tag`                           | Tag for the UI image<br>If not specified, `appVersion` from chart/Chart.yaml is used     | `""`                                               | `0.2.1`                                                                                                                                                                                                                |
| `ui.deployment.imagePullSecrets`                    | Image pull secrets for the UI                                                            | `[]`                                               | <pre>- name: my-secret</pre>                                                                                                                                                                                           |
| `ui.deployment.podAnnotations`                      | Annotations for the UI pod                                                               | `{}`                                               | <pre>key1: value1</pre>                                                                                                                                                                                                |
| `ui.deployment.podLabels`                           | Labels for the UI pod                                                                    | `{}`                                               | <pre>key1: value1</pre>                                                                                                                                                                                                |
| `ui.deployment.podSecurityContext`                  | Security context for the UI pod                                                          | `{}`                                               | <pre>fsGroup: 101</pre>                                                                                                                                                                                                |
| `ui.deployment.securityContext`                     | Security context for the UI                                                              | `{}`                                               | <pre>runAsUser: 101</pre>                                                                                                                                                                                              |
| `ui.deployment.resources`                           | Resources for the UI                                                                     | `{}`                                               | <pre>requests:<br>  memory: "64Mi"<br>  cpu: "250m"<br>limits:<br>  memory: "64Mi"<br>  cpu: "250m"</pre>                                                                                                              |
| `ui.deployment.livenessProbe.tcpSocket.port`        | Port for the UI liveness probe                                                           | `ui`                                               | `ui`                                                                                                                                                                                                                   |
| `ui.deployment.readinessProbe.tcpSocket.port`       | Port for the UI readiness probe                                                          | `ui`                                               | `ui`                                                                                                                                                                                                                   |
| `ui.deployment.volumes`                             | Volumes for the UI                                                                       | `[]`                                               | <pre>- name: my-volume<br>  persistentVolumeClaim:<br>    claimName: my-claim</pre>                                                                                                                                    |
| `ui.deployment.volumeMounts`                        | Volume mounts for the UI                                                                 | `[]`                                               | <pre>- name: my-volume<br>  mountPath: /path</pre>                                                                                                                                                                     |
| `ui.deployment.nodeSelector`                        | Node selector for the UI                                                                 | `{}`                                               | <pre>key1: value1</pre>                                                                                                                                                                                                |
| `ui.deployment.tolerations`                         | Tolerations for the UI                                                                   | `[]`                                               | <pre>- key: "key1"<br>  operator: "Equal"<br>  value: "value1"<br>  effect: "NoSchedule"</pre>                                                                                                                         |
| `ui.deployment.affinity`                            | Affinity for the UI                                                                      | `{}`                                               | <pre>nodeAffinity:<br>  requiredDuringSchedulingIgnoredDuringExecution:<br>    nodeSelectorTerms:<br>    - matchExpressions:<br>      - key: key1<br>        operator: In<br>        values:<br>        - value1</pre> |
| `nameOverride`                                      | Override the name of the chart                                                           | `""`                                               | `"mycustomname"`                                                                                                                                                                                                       |
| `fullnameOverride`                                  | Override the full name of the chart                                                      | `""`                                               | `"mycustomfullname"`                                                                                                                                                                                                   |
| `serviceAccount.create`                             | Create a service account                                                                 | `true`                                             | `true`                                                                                                                                                                                                                 |
| `serviceAccount.automount`                          | Automount the service account                                                            | `true`                                             | `true`                                                                                                                                                                                                                 |
| `serviceAccount.annotations`                        | Annotations for the service account                                                      | `{}`                                               | <pre>key1: value1</pre>                                                                                                                                                                                                |
| `serviceAccount.name`                               | Name of the service account, when not set `default` service account used                 | `""`                                               | `"mySA"`                                                                                                                                                                                                               |

## Uninstalling the Chart
To uninstall the `unitycatalog` deployment:

```sh
helm uninstall unitycatalog
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
If persistent volumes are used, they are not deleted by default. To delete them, you need to manually delete the PVCs.

## License
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
