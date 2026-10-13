output "lb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.this.arn
}