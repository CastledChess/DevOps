module "nginx_controller" {
  count = var.nginx_controller_enabled ? 1 : 0

  source  = "terraform-iaac/nginx-controller/helm"
  version = "2.3.0"

  name                                     = try(var.nginx_controller_set["name"], "ingress-nginx")
  namespace                                = try(var.nginx_controller_set["namespace"], "kube-system")
  chart_version                            = try(var.nginx_controller_set["chart_version"], null)
  atomic                                   = try(var.nginx_controller_set["atomic"], false)
  ingress_class_name                       = try(var.nginx_controller_set["ingress_class_name"], "nginx")
  ingress_class_is_default                 = try(var.nginx_controller_set["ingress_class_is_default"], true)
  ip_address                               = try(var.nginx_controller_set["ip_address"], "")
  controller_kind                          = try(var.nginx_controller_set["controller_kind"], "DaemonSet")
  controller_daemonset_useHostPort         = try(var.nginx_controller_set["controller_daemonset_useHostPort"], false)
  controller_service_externalTrafficPolicy = try(var.nginx_controller_set["controller_service_externalTrafficPolicy"], "Local")
  controller_request_memory                = try(var.nginx_controller_set["controller_request_memory"], 140)
  publish_service                          = try(var.nginx_controller_set["publish_service"], true)
  define_nodePorts                         = try(var.nginx_controller_set["define_nodePorts"], false)
  service_nodePort_http                    = try(var.nginx_controller_set["service_nodePort_http"], "32001")
  service_nodePort_https                   = try(var.nginx_controller_set["service_nodePort_https"], "32002")
  metrics_enabled                          = try(var.nginx_controller_set["metrics_enabled"], false)
  disable_heavyweight_metrics              = try(var.nginx_controller_set["disable_heavyweight_metrics"], false)
  create_namespace                         = try(var.nginx_controller_set["create_namespace"], false)
  additional_set                           = try(var.nginx_controller_set["additional_set"], [])
  wait                                     = try(var.nginx_controller_set["wait"], true)
  timeout                                  = try(var.nginx_controller_set["timeout"], null)
}
