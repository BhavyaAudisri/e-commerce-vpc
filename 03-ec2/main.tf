resource "aws_instance" "ecommerce" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.xlarge"
  subnet_id              = local.public_subnet_id
  vpc_security_group_ids = [data.aws_ssm_parameter.ecommerce_sg_id.value]
  key_name               = "e-commerce"
  associate_public_ip_address = true
  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "ecommerce"
  }
}