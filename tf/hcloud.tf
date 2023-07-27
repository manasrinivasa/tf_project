resource "hcloud_ssh_key" "demo_key" { 
    name = "${var.deployment_name}-key"
    public_key = file(var.hcloud_public_key)
}
resource "hcloud_server" "demo_server" { 
    name = "demo-server"
    image = "ubuntu-20.04"
    server_type = "cpx31"
    location = "ash"
    ssh_keys = [hcloud_ssh_key.demo_key.id]
    labels = { 
        type = "demo" 
        Name = "${var.deployment_name}-server"
    }
    
}