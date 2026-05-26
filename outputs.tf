output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "id" {
  description = "ID of the NAT gateway"
  value       = try(aws_nat_gateway.this[0].id, null)
}

output "public_ip" {
  description = "Public IP of the NAT gateway"
  value       = try(aws_nat_gateway.this[0].public_ip, null)
}

output "private_ip" {
  description = "Private IP of the NAT gateway"
  value       = try(aws_nat_gateway.this[0].private_ip, null)
}
