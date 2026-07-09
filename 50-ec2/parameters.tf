data "aws_ssm_parameter" "access_key" {
  name = "/ecommerce/aws/access-key"
  #overwrite = true
}

data "aws_ssm_parameter" "secret_key" {
  name            = "/ecommerce/aws/secret-key"
  with_decryption = true
  #overwrite = true
}