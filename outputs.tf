resource "local_file" "outputs_txt" {
  filename = "./outputs/server_info.txt"
  content = templatefile("./templates/server_info.txt.tmpl", {
    aws_instance_name  = aws_instance.dev_node.tags.Name
    aws_instance_ip    = aws_instance.dev_node.public_ip
  })
}
resource "local_file" "ansible_inventory" {
  filename = "./ansible/inventory.ini" 
  content = templatefile("./templates/ansible_inventory.txt.tmpl", {
    aws_instance_name  = aws_instance.dev_node[*].tags.Name
    aws_instance_ip = aws_instance.dev_node[*].public_ip
    private_key = var.private_key,
    ansible_user = var.user,
      }
    )
  
}

