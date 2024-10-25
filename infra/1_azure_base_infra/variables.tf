variable "resource_group_name" {
  description = "Nom du groupe de ressources"
  type        = string
  default     = "castled-chess-resource-group"
}

variable "cluster_name" {
  description = "Nom du cluster AKS"
  type        = string
  default     = "castled-chess-cluster"
}

variable "location" {
  description = "Localisation du cluster"
  type        = string
  default     = "eastus"
}

variable "node_count" {
  description = "Nombre de nœuds dans le pool"
  type        = number
  default     = 1
}
