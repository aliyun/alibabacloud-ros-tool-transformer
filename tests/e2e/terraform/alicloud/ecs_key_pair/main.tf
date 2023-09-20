resource "alicloud_ecs_key_pair" "example" {
  key_pair_name = "key_pair_name"
}

// Import an existing public key to build a alicloud key pair
resource "alicloud_ecs_key_pair" "publickey" {
  key_pair_name = "my_public_key"
  public_key    = "ssh-rsa AAAAB3Nza12345678qwertyuudsfsg"
}