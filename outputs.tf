output "db_instance_address" {
  description = "Hostname of the primary instance"
  value = aws_db_instance.db_instance.address
}

output "security_group_id" {
  description = "Security Group ID used by the instance/s"
  value = aws_security_group.security_group.id
}
