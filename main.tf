provider "kubernetes" {
  config_path    = var.config_path
  config_context = var.config_context
}

module "custom-cluster" {
  source          = "./resources"
  ns_name         = "kuard-ns"
  deployment_name = "kuard-deployment"
  container_img   = "gcr.io/kuar-demo/kuard-amd64:blue"
  container_name  = "kuard"

  port_settings = {
    cp       = 8080
    name     = "http"
    protocol = "TCP"
  }

  deployment_labels = {
    name        = "kuard-deployment"
    env         = "practice"
    is_verified = true
  }

  container_labels = {
    name        = "kuard"
    env         = "practice"
    is_verified = true
  }

  resource_reqs = {
    cpu    = "500m"
    memory = "128Mi"
  }

  resource_limits = {
    cpu    = "1000m"
    memory = "256Mi"
  }

  lp_http_get_path = "/healthy"
  lp_http_get_port = 8080
  rp_http_get_path = "/ready"
  rp_http_get_port = 8080

  lp_time_conf = {
    init_delay_sec = 5
    timeout_sec    = 1
    period_sec     = 10
    failure_th     = 3
  }

  rp_time_conf = {
    init_delay_sec = 50
    timeout_sec    = 1
  }
}