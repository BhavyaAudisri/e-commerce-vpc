output "product_tg_arn" {
  value = aws_lb_target_group.product_tg.arn
}

output "cart_tg_arn" {
  value = aws_lb_target_group.cart_tg.arn
}

output "user_tg_arn" {
  value = aws_lb_target_group.user_tg.arn
}

output "order_tg_arn" {
  value = aws_lb_target_group.order_tg.arn
}