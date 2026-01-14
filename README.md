# helm-keda

Crossplane configuration that installs the KEDA Helm chart with a minimal, stable interface.

## Overview

This configuration provides a Crossplane XRD for deploying KEDA (Kubernetes Event-driven Autoscaling) using the Helm provider. KEDA is a Kubernetes-based Event Driven Autoscaler that can drive scaling of any container based on the number of events needing to be processed.

## Usage

### Minimal Example

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Keda
metadata:
  name: keda
  namespace: my-namespace
spec:
  clusterName: my-cluster
```

### Standard Example

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Keda
metadata:
  name: keda
  namespace: my-namespace
spec:
  clusterName: my-cluster
  namespace: keda
  labels:
    team: platform
    environment: production
  providerConfigRef:
    name: my-cluster
    kind: ProviderConfig
  values:
    operator:
      replicaCount: 2
    metricsServer:
      replicaCount: 1
```

## Configuration Options

| Field | Description | Default |
|-------|-------------|---------|
| `clusterName` | Target cluster name (used for provider config) | Required |
| `namespace` | Kubernetes namespace for the release | `keda` |
| `name` | Helm release name | XR metadata.name |
| `labels` | Labels applied to managed resources | See below |
| `providerConfigRef.name` | Helm ProviderConfig name | `clusterName` |
| `providerConfigRef.kind` | ProviderConfig kind | `ProviderConfig` |
| `values` | Helm values (merged with defaults) | `{}` |
| `overrideAllValues` | Helm values (replaces all defaults) | `{}` |
| `managementPolicies` | Crossplane management policies | `["*"]` |

### Default Labels

```yaml
hops.ops.com.ai/managed: "true"
hops.ops.com.ai/keda: "<name>"
```

## Helm Chart

- **Chart**: keda
- **Repository**: https://kedacore.github.io/charts
- **Version**: 2.18.3

## Dependencies

- Provider: crossplane-contrib/provider-helm >= v1.0.6
- Function: crossplane-contrib/function-auto-ready >= v0.6.0
