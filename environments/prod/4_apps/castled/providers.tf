data "scaleway_k8s_cluster" "this" {
  name = "castledchess-prod"
}

provider "helm" {
  kubernetes {
    host                   = data.scaleway_k8s_cluster.this.kubeconfig[0].host
    token                  = data.scaleway_k8s_cluster.this.kubeconfig[0].token
    cluster_ca_certificate = base64decode(data.scaleway_k8s_cluster.this.kubeconfig[0].cluster_ca_certificate)
  }
}

provider "kubernetes" {
  host                   = data.scaleway_k8s_cluster.this.kubeconfig[0].host
  token                  = data.scaleway_k8s_cluster.this.kubeconfig[0].token
  cluster_ca_certificate = base64decode(data.scaleway_k8s_cluster.this.kubeconfig[0].cluster_ca_certificate)
}

provider "scaleway" {
  organization_id = "c41070e1-2967-4dde-8db5-dbf2f3cf63ba" # CastledChess Organization
  project_id      = "e22451fc-47b2-4a90-b3a0-b180e51154c9" # Production project
}
