variable "name" {
  description = "Name of the ExternalSecret to create"
  type        = string
}

variable "namespace" {
  description = "Namespace of the ExternalSecret to create"
  type        = string
}

variable "scaleway_secret_id" {
  description = "Scaleway's secret ID to use as source"
  type        = string
}
