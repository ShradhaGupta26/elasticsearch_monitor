resource "aws_security_group" "el_sg" {
  name        = "elasticsearch_sg"
  description = "Allow TLS inbound traffic"
  ingress {
    
      from_port   = 9114
      to_port     = 9114
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
 ingress {
      
      from_port   = 9200
      to_port     = 9200
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ingress {
    
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }



}