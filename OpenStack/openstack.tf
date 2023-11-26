// Create a web server
resource "openstack_compute_instance_v2" "Terraform_automation" {
  name = "web machine"
  image_id = "<image_id>"
  flavor_id = "<flavor_id>"
  security_groups = ["default"]

  network {
        name = "<network_name>"
  }
}
