# aws instance outputs file 
resource "local_file" "outputs_txt" {
  filename = "./outputs/server_info.txt"
  content = templatefile("./templates/server_info.txt.tmpl", {
    aws_instance_name  = aws_instance.dev_node.tags.Name
    aws_instance_ip    = aws_instance.dev_node.public_ip
  })
}
# ansible inventory outputs file 
resource "local_file" "ansible_inventory" {
  filename = "./ansible/inventory.ini" 
  content = templatefile("./templates/ansible_inventory.txt.tmpl", {
    aws_instance_name  = aws_instance.dev_node[*].tags.Name
    aws_instance_ip = aws_instance.dev_node[*].public_ip
    private_key = var.private_key,
    ansible_user = var.user,
    hcloud_server_name = hcloud_server.demo_server.labels.Name
    hcloud_server_ip = hcloud_server.demo_server.ipv4_address 
    hcloud_private_key = var.hcloud_private_key
    hcloud_os_type = var.hcloud_os_type
      }
    )
}
resource "local_file" "hcloud_outputs_txt" {
  filename = "./outputs/hcloud_server_info.txt"
  content = templatefile("./templates/hcloudserver_info.txt.tmpl", {
    hcloud_server_name = hcloud_server.demo_server.labels.Name
    hcloud_server_ip = hcloud_server.demo_server.ipv4_address 
  }
  )
}

