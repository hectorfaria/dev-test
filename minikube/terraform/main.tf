terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

/* provider "helm" {
 kubernetes {
   config_context = "minikube"
 }
}

resource "helm_release" "dev-test" {
 name  = "dev-test"
 chart = "${abspath(path.root)}/charts/dev-test-chart"
} */