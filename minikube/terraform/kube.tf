resource "kubernetes_namespace" "dev-test" {
  metadata {
    name   = var.namespace
    labels = local.dev_test_labels
  }
}

resource "kubernetes_deployment" "dev-test-deploy" {
  metadata {
    name      = var.deployment_name
    labels    = local.dev_test_labels
    namespace = var.namespace
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = local.dev_test_labels
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_unavailable = 2
        max_surge       = 2
      }
    }

    template {
      metadata {
        labels = local.dev_test_labels
      }

      spec {
        restart_policy = "Always"
        container {
          image = var.image_name
          name  = "dev-test"
          port {
            container_port = var.image_port
          }
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }

  }
}

resource "kubernetes_ingress_v1" "dev-test-ingress" {
  metadata {
    name      = var.ingress
    namespace = var.namespace
    labels    = local.dev_test_labels
  }

  spec {
    rule {
      host = var.host_name
      http {
        path {
          backend {
            service {
              name = var.service_name
              port {
                number = var.node_port
              }
            }
          }

          path = "/*"
        }
      }
    }
  }
}

resource "kubernetes_service" "dev-test-srv" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
    labels    = local.dev_test_labels
  }
  spec {
    selector         = local.dev_test_labels
    session_affinity = "ClientIP"
    port {
      port        = var.node_port
      target_port = var.image_port
    }
    type = "LoadBalancer"
  }
}

resource "kubernetes_horizontal_pod_autoscaler" "dev-test-hpa" {
  metadata {
    name      = var.horizontal_pod_autoscaler
    namespace = var.namespace
    labels    = local.dev_test_labels
  }

  spec {
    max_replicas = var.max_replicas
    min_replicas = var.replicas

    target_cpu_utilization_percentage = 80

    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = var.deployment_name
    }
  }
}
