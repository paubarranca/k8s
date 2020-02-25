# RBAC Resources

<h2>Role and ClusterRole</h2>

Define permissions within a namespace (Role) or an entire cluster (ClusterRole).

<h4>Role</h4>

* Define access to resources in a single namespace

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

<h4>ClusterRole</h4>

* Define access to resources of an entire cluster

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: secret-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["secrets"]
  verbs: ["get", "watch", "list"]
```


<h2>RoleBinding and ClusterRoleBinding</h2>

Grants the permissions defined in a role to a user or group of users. It holds a list of subjects (users, groups, service accounts), and a reference to the role granted. Permissions can be granted within a namespace (RoleBinding) or an entire cluster (ClusterRoleBinding).

<h4>RoleBinding</h4>

* Bind a Role defined in a single namespace to a user, group or service account

* User

```yaml
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
  # GCP user account
- kind: User
  name: jane@example.com
  # Cluster user
- kind: User
  name: Jane  # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

* Group

```yaml
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
  # G Suite Google Group
- kind: Group
  name: projects-group@example.com
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

* Service Account

```yaml
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
  # K8s service account
- kind: ServiceAccount
  name: myserviceaccount
  # Cloud IAM service account
  - kind: User
  name: test-account@test-project-123456.google.com.iam.gserviceaccount.com
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

<h4>ClusterRoleBinding</h4>

* Bind a ClusterRole defined in an entire cluster to a user, group or service account

* User

```yaml
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
kind: ClusterRoleBinding
metadata:
  name: read-pods
subjects:
  # GCP user account
- kind: User
  name: jane@example.com
  # Cluster user
- kind: User
  name: Jane  # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: secret-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

* Group

```yaml
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
kind: ClusterRoleBinding
metadata:
  name: read-pods
subjects:
  # G Suite Google Group
- kind: Group
  name: projects-group@example.com
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: secret-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

* Service Account

```yaml
apiVersion: rbac.authorization.k8s.io/v1
# This role binding allows "jane" to read pods in the "default" namespace.
kind: ClusterRoleBinding
metadata:
  name: read-pods
subjects:
  # K8s service account
- kind: ServiceAccount
  name: myserviceaccount
  # Cloud IAM service account
  - kind: User
  name: test-account@test-project-123456.google.com.iam.gserviceaccount.com
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: secret-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

