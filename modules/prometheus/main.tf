resource "aws_instance" "prometheus" {
  ami           = data.aws_ami.amazon-linux.id
  instance_type = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.prom_sg.id}"]
  
  tags = {
    Name = "prometheus"
  }
#    user_data = "${file("init.sh")}"
    user_data = "${data.template_file.promscript.rendered}"
}