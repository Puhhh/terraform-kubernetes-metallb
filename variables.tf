variable "kubeconfig-path" {
  description = "Kubeconfig Path"
  type        = string
  default     = "~/.kube/config"
}

variable "metallb-namespace" {
  description = "Metallb Namespace"
  type        = string
  default     = "metallb-system"
}

variable "namespace-labels" {
  description = "Namespace Labels"
  type        = map(string)
  default = {
    "pod-security.kubernetes.io/enforce" = "privileged"
    "pod-security.kubernetes.io/audit"   = "privileged"
    "pod-security.kubernetes.io/warn"    = "privileged"
  }
}

variable "helm-name" {
  description = "Helm Release Name"
  type        = string
  default     = "metallb"
}

variable "helm-chart-name" {
  description = "Helm Chart Name"
  type        = string
  default     = "metallb"
}

variable "helm-chart-repo" {
  description = "Helm Chart Repo"
  type        = string
  default     = "https://metallb.github.io/metallb"
}

variable "helm-chart-version" {
  description = "Helm Chart Version"
  type        = string
  default     = "0.14.5"
}

variable "helm-custom-values" {
  description = "Use Helm Custom Values"
  type        = bool
  default     = false
}

variable "helm-custom-values-path" {
  description = "Helm Custom Values Path"
  type        = string
  default     = ""

  validation {
    condition     = !(var.helm-custom-values && var.helm-custom-values-path == "")
    error_message = "helm-custom-values-path must not be null when helm-custom-values is true."
  }
}

variable "ipaddresspool-start" {
  description = "IPAddressPool Start IP Address"
  type        = string
  default     = ""
}

variable "ipaddresspool-end" {
  description = "IPAddressPool End IP Address"
  type        = string
  default     = ""
}
