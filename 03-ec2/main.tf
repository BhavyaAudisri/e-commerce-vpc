resource "aws_instance" "ecommerce" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.xlarge"
  subnet_id              = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids = [module.ecommerce_sg.sg_id]
  key_name               = "e-commerce"
  associate_public_ip_address = true
  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "ecommerce"
  }
}