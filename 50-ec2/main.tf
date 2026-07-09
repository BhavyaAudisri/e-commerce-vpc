resource "aws_instance" "ecommerce" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.xlarge"
  subnet_id              = local.public_subnet_id
  vpc_security_group_ids = [data.aws_ssm_parameter.ecommerce_sg_id.value]
  key_name               = "e-commerce"
  associate_public_ip_address = true
  connection {
    type        = "ssh"
    user        = "ubuntu"                     # Amazon Linux: ec2-user
    host        = self.public_ip
    private_key = file("${path.module}/e_commerce.pem")
    timeout     = "5m"
  }
   provisioner "file" {
    source      = "${path.module}/userdata.sh"
    destination = "/tmp/userdata.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/userdata.sh",
      "sudo /tmp/userdata.sh"
    ]
  }

  access_key   = data.aws_ssm_parameter.access_key.value
  secret_key   = data.aws_ssm_parameter.secret_key.value
  GITHUB_TOKEN  = data.aws_ssm_parameter.github_token.value
  user_pool_id = data.aws_ssm_parameter.user_pool_id.value
  app_client_id = data.aws_ssm_parameter.app_client_id.value
 
  user_data_replace_on_change = true

  tags = {
    Name = "ecommerce"
  }
}

resource "aws_route53_record" "cdn" {
 zone_id = var.zone_id
 name = "${var.domain_name}"
 type = "A"
 alias {
    name = data.aws_cloudfront_distribution.cdn.domain_name
    zone_id = data.aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
        }
}