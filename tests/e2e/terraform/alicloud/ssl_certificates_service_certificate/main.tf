resource "alicloud_ssl_certificates_service_certificate" "example" {
  certificate_name = "test"
  cert             = "test-cert"
  key              = "test-key"
}