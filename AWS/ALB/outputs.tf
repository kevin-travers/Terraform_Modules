output "id" {
    description = "The ARN of the load balancer (matches arn)."
    value = aws_alb.alb.id
}
output "arn" {
    description = "The ARN of the load balancer (matches id)."
    value = aws_alb.alb.arn
}
output "arn_suffix" {
    description = " The ARN suffix for use with CloudWatch Metrics."
    value = aws_alb.alb.arn_suffix
}
output "dns_name" {
    description = "The DNS name of the load balancer."
    value = aws_alb.alb.dns_name
}
output "zone_id" {
    description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)."
    value = aws_alb.alb.zone_id
}

