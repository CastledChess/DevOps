variable "k8s_security_namespace" {
  type        = string
  description = "The namespace for the security stack"
  default     = "security"
}

variable "dtrack_enabled" {
  type        = bool
  description = "Whether to enable the DTrack service"
  default     = true
}

