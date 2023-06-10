resource "tls_private_key" "demo_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096

}

resource "aws_key_pair" "demo_kp" {
  key_name   = "demo-key"
  public_key = tls_private_key.demo_pk.public_key_openssh

}

resource "local_file" "private_key_pair" {
  content         = tls_private_key.demo_pk.private_key_pem
  filename        = "${aws_key_pair.demo_kp.key_name}.pem"
  file_permission = 0400

  provisioner "local-exec" {
    command = "chmod 400 ${aws_key_pair.demo_kp.key_name}.pem"
  }
}
