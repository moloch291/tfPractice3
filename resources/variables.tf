variable "ns_name" {
  type        = string
  description = "Name of the kuard namespace"
}

variable "deployment_labels" {
  description = "Labels of the deployment"
  type        = map(any)
}

variable "container_labels" {
  description = "Labels of the containers"
  type        = map(any)
}

variable "deployment_name" {
  type        = string
  description = "Name of the kuard deployment"
}

variable "container_img" {
  type        = string
  description = "Image of the container"
}

variable "container_name" {
  type        = string
  description = "Name of the container"
}

variable "resource_limits" {
  description = "Limits of resources of deployment"
  type        = map(any)
}

variable "resource_reqs" {
  description = "Requested resources of deployment"
  type        = map(any)
}

variable "lp_http_get_path" {
  type        = string
  description = "Path of the http get liveness probe"
}

variable "lp_http_get_port" {
  type        = number
  description = "Port of the http get liveness probe"
}

variable "lp_time_conf" {
  type        = map(any)
  description = "Map for time config of liveness probe"
}

variable "rp_http_get_path" {
  type        = string
  description = "Path of the http get readiness probe"
}

variable "rp_http_get_port" {
  type        = number
  description = "Port of the http get readiness probe"
}

variable "rp_time_conf" {
  type        = map(any)
  description = "Map for time config of readiness probe"
}

variable "port_settings" {
  type        = map(any)
  description = "Settings of the container port"
}