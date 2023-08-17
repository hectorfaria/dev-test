locals {
  dev_test_labels = {
    app  = "dev-test"
    tier = "backend"
  }
}

variable "image_port" {
  type        = number
  default     = 8000
  description = "The port the docker image is forwarding to"
}

variable "node_port" {
  type        = number
  default     = 32000
  description = "The port the Service Node port is forwarding to"
}

variable "replicas" {
  type        = number
  default     = 2
  description = "The minimum number of replicas you want to boot"
}

variable "max_replicas" {
  type        = number
  default     = 5
  description = "The max number of replicas you want to boot"
}

variable "namespace" {
  type        = string
  default     = "dev-test-ns"
  description = "The name of the namespace"
}

variable "service_name" {
  type        = string
  default     = "dev-test-srv"
  description = "The name of the service"
}

variable "deployment_name" {
  type        = string
  default     = "dev-test-deploy"
  description = "The name of the deployment"
}

variable "horizontal_pod_autoscaler" {
  type        = string
  default     = "dev-test-hpa"
  description = "The name of the horizontal pod autoscaler"
}

variable "image_name" {
  type        = string
  default     = "hectorfaria/dev-test"
  description = "The name of the Docker image"
}

variable "ingress" {
  type        = string
  default     = "dev-test-ingress"
  description = "The name of the Ingress for the service"
}