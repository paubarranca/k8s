# Pod Security Policies

A Pod Security Policy is an object that controls sensitive aspects about the security of the pod specification. 

Pod Security Policy Control is an optional admission controller, the PodSecurityPolicies are enforced by enabling the [admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#how-do-i-turn-on-an-admission-control-plug-in).

The preferred method for authorizing policies is to grant access to the pod's service account with RBAC. Check **pod-security-policy-restricted.yaml** to see an example.  

To understand the architecture and purpose about the controller and the objects check [Kubernetes documentation](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#what-is-a-pod-security-policy).

<h2>Policy Reference</h2>

[Fully explained policies references](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#policy-reference)

<h3>Privileged</h3>

**Privileged** - Determines if any container within a pod can enable privileged mode, that allows it to access devices on the host. Basically the container will have the same access as processes running on the host.

<h3>Host namespaces</h3>

**HostPID** - Controls whether the pod containers can share the host process ID namespace.

**HostIPC** - Controls whether the pod containers can share the host IPC namespace.

**HostNetwork** - Controls whether the pod may use the node network namespace. Doing so gives the pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other pods on the same node.

**HostPorts** - Provides a whitelist of ranges of allowable ports in the host network namespace. Defined as a list of HostPortRange, with min(inclusive) and max(inclusive). Defaults to no allowed host ports.

<h3>Volumes and File Systems</h3>

**Volumes** - Provides a whitelist of allowed volume types. The minimum set recommended are: [configMap](https://cloud.google.com/kubernetes-engine/docs/concepts/configmap?hl=es-419), [secret](https://kubernetes.io/docs/concepts/configuration/secret/), [downwardAPI](https://kubernetes.io/docs/tasks/inject-data-application/downward-api-volume-expose-pod-information/), [emptyDir](https://kubernetes.io/docs/concepts/storage/#emptydir), [PVC](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims), [projected](https://kubernetes.io/docs/tasks/configure-pod-container/configure-projected-volume-storage/)

**FSGroup** - Controls supplemental group applied to some volumes

**AllowedHostPaths** - Specifies a whitelist of host paths that can be used as hostPath volumes

**ReadOnlyRootFilesystem** - No writable layer

<h3>Users and Groups</h3>

**RunAsUser** - With which user ID the containers will run

**RunAsGroup** - With which primary group ID the containers will run

**SupplementalGroups** - With which supplemental group/s ID/s the containers will run

<h3>Privilege Escalation</h3>

**AllowPrivilegeEscalation** - Gates whether or not a user is allowed to set the security context of a container to allowPrivilegeEscalation=true

**DefaultAllowPrivilegeEscalation** - Default AllowPrivilegeEscalation option