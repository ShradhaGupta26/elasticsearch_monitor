data "aws_ami" "amazon-linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  owners = ["amazon"]
}

data "template_file" "promscript" {
template = file("${path.module}/script.sh")
vars = {
    pip = var.instance_private_ip

}
}