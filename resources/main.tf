resource "kubernetes_namespace" "practice" {
  metadata {
    name = var.ns_name
  }
}

resource "kubernetes_deployment" "kuard" {
  metadata {
    namespace = var.ns_name
    name      = var.deployment_name

    labels = {
      for key, val in var.deployment_labels : key => val
      if lookup({key = val}, "is_verified", true) == true
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        name = "kuard"
        env  = "practice"
      }
    }

    template {
      metadata {
        labels = {
          for key, val in var.container_labels : key => val
          if lookup({key = val}, "is_verified", true) == true
        }
      }

      spec {
        container {
          image = var.container_img
          name  = var.container_name

          port {
            container_port = var.port_settings.cp
            name           = var.port_settings.name
            protocol       = var.port_settings.protocol
          }

          resources {
            limits = {
              for key, val in var.resource_limits : key => val
            }
            requests = {
              for key, val in var.resource_reqs : key => val
            }
          }

          liveness_probe {
            http_get {
              path = var.lp_http_get_path
              port = var.lp_http_get_port
            }
            initial_delay_seconds = var.lp_time_conf.init_delay_sec
            timeout_seconds       = var.lp_time_conf.timeout_sec
            period_seconds        = var.lp_time_conf.period_sec
            failure_threshold     = var.lp_time_conf.failure_th
          }

          readiness_probe {
            http_get {
              path = var.rp_http_get_path
              port = var.rp_http_get_port
            }
            initial_delay_seconds = var.rp_time_conf.init_delay_sec
            timeout_seconds       = var.rp_time_conf.timeout_sec
          }
        }
      }
    }
  }
}