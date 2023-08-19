output "namespace" {
    value       = kubernetes_namespace.dev-test.metadata
    description = "Name Space"
}

output "deployment" {
    value       = kubernetes_deployment.dev-test-deploy.spec
    description = "deployment"
}

output "ingress" {
    value       = kubernetes_ingress_v1.dev-test-ingress.spec
    description = "Ingress controller"
}

output "service" {
    value       = kubernetes_service.dev-test-srv.spec
    description = "Service NodePort"
}

output "hpa" {
    value = kubernetes_horizontal_pod_autoscaler.dev-test-hpa.spec
    description = "HorizontalPodAutoscaler"
}