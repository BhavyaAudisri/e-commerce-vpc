resource "aws_instance" "ecommerce" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.xlarge"
  subnet_id              = local.public_subnet_id
  vpc_security_group_ids = [data.aws_ssm_parameter.ecommerce_sg_id.value]
  key_name               = "e-commerce"
  associate_public_ip_address = true
  user_data = file("${path.module}/userdata.sh")
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