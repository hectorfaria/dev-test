resource "kubernetes_secret" "dev-test-tls" {
  metadata {
    name      = var.tls_secret
    namespace = var.namespace
  }

  data = {
    "tls.crt" = tls_self_signed_cert.ca.cert_pem
    "tls.key" = tls_self_signed_cert.ca.private_key_pem
  }

  type = "kubernetes.io/tls"
}  