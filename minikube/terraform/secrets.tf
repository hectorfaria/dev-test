resource "kubernetes_secret" "dev-test-pass" {
  metadata {
    name = "dev-test-pass"
    namespace = var.namespace  
  }
  data = {
    password = "password"
  }
}