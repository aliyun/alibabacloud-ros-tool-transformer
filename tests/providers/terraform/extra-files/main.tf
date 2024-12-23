locals {
    command  = file ("${path.module}/test.txt")
  }
resource "helm_release" "example" {
  name       = "my-local-chart"
  chart      = "./charts/example"
}
resource "helm_release" "example2" {
  name       = "my-redis-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "6.0.1"

  values = [
    "${file("${path.module}/values.yaml")}"
  ]

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }

  set {
    name  = "service.annotations.prometheus\\.io/port"
    value = "9127"
    type  = "string"
  }
}
output "content" {
  value = local.command
}
