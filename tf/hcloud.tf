resource "hcloud_ssh_key" "demo_key" { 
    name = "${var.deployment_name}-key"
    public_key = file(var.public_key)
}

data "template_file" "hcloud_init" {
  count       = var.hcloud_enabled ? 1 : 0
  template = "${file("./userdata.tpl")}"
  vars = {
      user = var.user
      ssh-pub = file(var.public_key)
  }
}

resource "hcloud_server" "demo_server" { 
    name = "${var.deployment_name}-demo-server"
    image = var.hcloud_os_type
    server_type = var.hcloud_server_type
    location = var.hcloud_location
    ssh_keys = [hcloud_ssh_key.demo_key.id]
    user_data = "${data.template_file.hcloud_init[0].rendered}"
    labels = { 
        type = "demo" 
        Name = "${var.deployment_name}-server"
    }
    
}