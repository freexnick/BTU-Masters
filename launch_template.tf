
resource "aws_launch_template" "demo_template" {
  name          = "demo_template"
  image_id      = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.demo_kp.key_name
  user_data     = filebase64("./nginx.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "demo-instance"
    }
  }
  network_interfaces {
    associate_public_ip_address = true
  }
  lifecycle {
    create_before_destroy = true
  }
}
