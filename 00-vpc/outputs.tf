output "azs_info" {
  value = data.aws_availability_zones.available
}
output "elastic_ip" {
  value = aws_eip.nat.id
}
output "pub_route_id" {
  value = aws_route_table.public.id
}
output "pri_route_id" {
  value = aws_route_table.private.id
}
output "db_route_id" {
  value = aws_route_table.database.id
}
output "default_vpc_id" {
  value = local.default_vpc_id

}
output "default_vpc_cidr_block" {
  value = local.default_vpc_cidr
}
output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  value = aws_subnet.database[*].id
}
output "gw_id" {
  value = aws_internet_gateway.main.id
}