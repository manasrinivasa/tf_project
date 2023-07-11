locals { 
name = var.deployment_name 
ip = aws_instance.dev_node [*].public_ip
} 
resource "local_file" "outputs_txt" {
  filename = "/path/to/main.tf"
  content = templatefile("${path.module}/outputs.tmpl", {
    outputs_name = local.name,
    outputs_ip   = local.ip,
    aws_name  = aws_instance.dev_node[*].tags.Name
    aws_ip    = aws_instance.dev_node[*].public_ip
    host_info = "${formatlist("%s: %s", local.name, local.ip)}"
  })
}
