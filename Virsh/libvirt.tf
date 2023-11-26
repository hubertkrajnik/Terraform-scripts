// Defining VM Volume
resource "libvirt_volume" "centos7-qcow2" {
  name = "centos7.qcow2"
  pool = "default"
  source = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  //source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

// get user data info
data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

// Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "commoninit" {
  name = "commoninit.iso"
  pool = "default" // List storage pools using virsh pool-list
  user_data = "${data.template_file.user_data.rendered}"
}

// Define KVM domain to create
resource "libvirt_domain" "CentOS machine" {
  name   = "CentOS machine" // nazwa widoczna podczas komendy # virsh list
  memory = "2048"
  vcpu   = 2

  network_interface {
    network_name = "default"
    hostname = "web-server" // nazwa widoczna podczas wykonywania komendy # virsh net-dhcp-leases default
    addresses = ["<ip-address>"] // ip statycznie przypisane z puli adresów sieci virsh, w tym przypadku domyślna się o nazwie "default"
  }

  disk {
    volume_id = "${libvirt_volume.centos7-qcow2.id}" // odniesienie do zdefiniowanego wcześniej volumenu na górze
  }

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}" // odniesienie do zdefiniowanego wcześniej skryptu cloud_init

  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}
