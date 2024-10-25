variable "api_name" {
  type        = string
  description = "Nom de l'image de l'API"
  default     = "castled-chess-api"
}

variable "frontend_name" {
  type        = string
  description = "Nom de l'image de l'API"
  default     = "castled-chess-front"
}

variable "docker_hub_username" {
  type    = string
  default = "oualidepitech"
}

variable "namespaces" {
  description = "Liste des namespaces à créer dans Kubernetes"
  type        = list(string)
  default     = ["api", "frontend"]
}
