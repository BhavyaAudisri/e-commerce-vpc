resource "aws_instance" "ecommerce" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.xlarge"
  subnet_id                   = local.public_subnet_id
  vpc_security_group_ids      = [data.aws_ssm_parameter.ecommerce_sg_id.value]
  key_name                    = "ecommerce"
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = self.public_ip
    private_key = file("${path.module}/ecommerce.pem")
    timeout     = "5m"
  }

  provisioner "file" {
    source      = "${path.module}/userdata.sh"
    destination = "/tmp/userdata.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/userdata.sh",
      <<-EOT
      set -e
      export ACCESS_KEY='${data.aws_ssm_parameter.access_key.value}'
      export SECRET_KEY='${data.aws_ssm_parameter.secret_key.value}'
      export USER_POOL_ID='${data.aws_ssm_parameter.user_pool_id.value}'
      export APP_CLIENT_ID='${data.aws_ssm_parameter.app_client_id.value}'

      test -f /tmp/userdata.sh || { echo "ERROR: userdata.sh not found"; exit 1; }

      test -n "$ACCESS_KEY" || { echo "ERROR: ACCESS_KEY is empty"; exit 1; }
      test -n "$SECRET_KEY" || { echo "ERROR: SECRET_KEY is empty"; exit 1; }
      test -n "$USER_POOL_ID" || { echo "ERROR: USER_POOL_ID is empty"; exit 1; }
      test -n "$APP_CLIENT_ID" || { echo "ERROR: APP_CLIENT_ID is empty"; exit 1; }

      sudo --preserve-env=ACCESS_KEY,SECRET_KEY,USER_POOL_ID,APP_CLIENT_ID \
        bash -x /tmp/userdata.sh
    EOT
    ]
  }

  tags = {
    Name = "ecommerce"
  }
}

resource "aws_route53_record" "cdn" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = data.aws_cloudfront_distribution.cdn.domain_name
    zone_id                = data.aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = false
  }
}