output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = "${aws_instance.elasticsearch.public_ip}"
}
output "instance_private_ip" {
  description = "Public IP of EC2 instance"
  value       = "${aws_instance.elasticsearch.private_ip}"
}