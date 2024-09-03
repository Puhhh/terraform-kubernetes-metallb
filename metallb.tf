resource "kubernetes_namespace" "metallb-namespace" {
  metadata {
    name   = var.metallb-namespace
    labels = var.namespace-labels
  }
}

resource "helm_release" "metallb" {
  namespace  = kubernetes_namespace.metallb-namespace.metadata[0].name
  name       = var.helm-name
  chart      = var.helm-chart-name
  repository = var.helm-chart-repo
  version    = var.helm-chart-version

  values = var.helm-custom-values ? [file(var.helm-custom-values-path)] : []
}

resource "kubectl_manifest" "ipaddresspool" {
  depends_on = [helm_release.metallb]

  yaml_body = <<YAML
  apiVersion: metallb.io/v1beta1
  kind: IPAddressPool
  metadata:
    name: default-pool
    namespace: ${kubernetes_namespace.metallb-namespace.metadata[0].name}
  spec:
    addresses:
      - ${var.ipaddresspool-start}-${var.ipaddresspool-end}
  YAML
}

resource "kubectl_manifest" "l2advertisement" {
  depends_on = [helm_release.metallb]

  yaml_body = <<YAML
  apiVersion: metallb.io/v1beta1
  kind: L2Advertisement
  metadata:
    name: default
    namespace: ${kubernetes_namespace.metallb-namespace.metadata[0].name}
  spec:
    ipAddressPools:
      - default-pool
  YAML
}
