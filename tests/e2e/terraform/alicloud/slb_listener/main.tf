variable "slb_listener_name" {
  default = "forSlbListener"
}

resource "alicloud_slb_load_balancer" "listener" {
  load_balancer_name   = "tf-exampleSlbListenerHttp"
  internet_charge_type = "PayByTraffic"
  address_type         = "internet"
  instance_charge_type = "PayByCLCU"
}

resource "alicloud_slb_listener" "listener" {
  load_balancer_id          = alicloud_slb_load_balancer.listener.id
  backend_port              = 80
  frontend_port             = 80
  protocol                  = "http"
  bandwidth                 = 10
  sticky_session            = "on"
  sticky_session_type       = "insert"
  cookie_timeout            = 86400
  cookie                    = "tfslblistenercookie"
  health_check              = "on"
  health_check_domain       = "ali.com"
  health_check_uri          = "/cons"
  health_check_connect_port = 20
  healthy_threshold         = 8
  unhealthy_threshold       = 8
  health_check_timeout      = 8
  health_check_interval     = 5
  health_check_http_code    = "http_2xx,http_3xx"
  x_forwarded_for {
    retrive_slb_ip = true
    retrive_slb_id = true
  }
  acl_status      = "on"
  acl_type        = "white"
  acl_id          = alicloud_slb_acl.listener.id
  request_timeout = 80
  idle_timeout    = 30
}

resource "alicloud_slb_acl" "listener" {
  name       = var.slb_listener_name
  ip_version = "ipv4"
}

resource "alicloud_slb_acl_entry_attachment" "first" {
  acl_id  = alicloud_slb_acl.listener.id
  entry   = "10.10.10.0/24"
  comment = "first"
}

resource "alicloud_slb_acl_entry_attachment" "second" {
  acl_id  = alicloud_slb_acl.listener.id
  entry   = "168.10.10.0/24"
  comment = "second"
}