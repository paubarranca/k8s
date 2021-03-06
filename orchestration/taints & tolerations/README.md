# Taints & Tolerations

A taint allows a node to refuse pods to be scheduled unless that pod has a toleration for that taint. The taints are applied through node specification **(NodeSpec)** and the tolerations are applied through pod specification **(PodSpec)**.

Taints and Tolerations consists of a key, value and effect but, depending on the case, it's not necessary to use them all.

A few use cases to use taints and tolerations could be:

* dedicated nodes - if you want a set of nodes dedicated exclusively for certain pods, users...
* nodes with dedicated special hardware - if you have nodes with GPU or another specialized hardware and only want to run certain workloads in them

<h2>Components</h2>

* key
* value
* effect
    * noSchedule - New pods that don't match the taint are not scheduled, existing pods in the node that don't have a toleration remain
    * preferNoSchedule - New pods that don't match the taint might be scheduled, but the scheduler tries not to, existing pods in the node remain
    * noExecute - New pods that don't match the taint are not scheduled, existing pods in the node that don't have a toleration are removed
* operator
    * equal - key/value/effect parameters must match. Default
    * exists - key/effect must match. Must leave a blank value parameter, which matches any

<h2>Practical examples</h2>

<h4>Single taint</h4>

```bash
kubectl taint nodes node1 key2=value2:NoSchedule
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
  tolerations:
  - key: "key2"
    value: "value2"
    effect: "NoSchedule"
```

<h4>Multi taint</h4>

```bash
kubectl taint nodes node1 key2=value2:NoSchedule
kubectl taint nodes node1 key1=value1:NoExecute
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
  tolerations:
  - key: "key2"
    value: "value2"
    effect: "NoSchedule"
  - key: "key1"
    operator: "Equal"
    value: "value1"
    effect: "NoExecute"
```

<h2>Taint nodes</h2>

In Kubernetes 1.6 was added as an alpha feature, the node controller automatically taints a node when certain condition is true. These ones are built in:

* ```node.kubernetes.io/not-ready``` - Corresponds to NodeCondition **Ready** being false
* ```node.kubernetes.io/unreachable``` - Corresponds to NodeCondition **Ready** being unknown
* ```node.kubernetes.io/out-of-disk```
* ```node.kubernetes.io/memory-pressure```
* ```node.kubernetes.io/disk-pressure```
* ```node.kubernetes.io/network-unavailable```
* ```node.kubernetes.io/unschedulable```
* ```node.cloudprovider.kubernetes.io/uninitialized``` - When the kubelet is started with external cloud provider, this taint marks the node as unusable, after the cloud-controller-manager initialized this node, the kubelet removes this taint

Combining these taints with tolerationSeconds can help you specify how long a pod should stay bound to a node that has one or more of these problems.

<h4>Example</h4> 

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
  tolerations:
  - key: "node.kubernetes.io/unreachable"
    operator: "Exists"
    effect: "NoExecute"
    tolerationSeconds: 6000
```