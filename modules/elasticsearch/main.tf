
resource "aws_instance" "elasticsearch" {
  ami           = data.aws_ami.amazon-linux.id
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.el_sg.id}"]
  tags = {
    Name = "elasticsearch"
  }
   user_data = file("${path.module}/script.sh")
}
