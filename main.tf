data "aws_caller_identity" "current" {}

resource "aws_security_group" "security_group" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id
  tags   = var.tags
}

resource "aws_security_group_rule" "egress_allow_all" {
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "0"
  protocol          = "-1"
  security_group_id = aws_security_group.security_group.id
  to_port           = "0"
}

resource "aws_db_parameter_group" "db_parameter_group" {
  name   = "${var.name}-db-parameter-group"
  family = var.family
  tags   = var.tags

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.key
      value        = parameter.value
      apply_method = "pending-reboot"
    }
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_db_instance" "db_instance" {
  allocated_storage               = var.allocated_storage
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  apply_immediately               = var.apply_immediately
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.backup_window
  copy_tags_to_snapshot           = true
  db_subnet_group_name            = aws_db_subnet_group.db_subnet_group.id
  delete_automated_backups        = var.delete_automated_backups
  deletion_protection             = true
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  engine                          = var.engine
  engine_version                  = var.engine_version
  final_snapshot_identifier       = "${var.name}-final"
  identifier                      = var.name
  instance_class                  = var.instance_class
  iops                            = var.iops
  maintenance_window              = var.maintenance_window
  monitoring_interval             = (var.enable_monitoring == true ? "60" : "0")
  monitoring_role_arn             = (var.enable_monitoring == true ? "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/rds-monitoring-role" : null)
  multi_az                        = var.multi_az
  name                            = var.db_name
  parameter_group_name            = aws_db_parameter_group.db_parameter_group.id
  password                        = var.password
  port                            = var.port
  snapshot_identifier             = var.snapshot_identifier
  storage_encrypted               = var.storage_encrypted
  storage_type                    = var.storage_type
  username                        = var.username
  vpc_security_group_ids          = [aws_security_group.security_group.id]
  performance_insights_enabled    = var.performance_insights_enabled
  tags                            = var.tags
}

resource "aws_db_instance" "db_instance_replica" {
  count = (var.has_replica == true ? "1" : "0")

  allocated_storage               = var.allocated_storage
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  apply_immediately               = var.apply_immediately
  backup_retention_period         = var.backup_retention_period
  backup_window                   = var.replica_backup_window
  copy_tags_to_snapshot           = true
  db_subnet_group_name            = aws_db_subnet_group.db_subnet_group.id
  deletion_protection             = true
  enabled_cloudwatch_logs_exports = (var.engine == "postgres" ? ["postgresql"] : ["error", "slowquery"])
  engine                          = var.engine
  engine_version                  = var.engine_version
  final_snapshot_identifier       = "${var.name}-replica-final"
  identifier                      = "${var.name}-replica"
  instance_class                  = var.instance_class
  iops                            = var.iops
  maintenance_window              = var.replica_maintenance_window
  monitoring_interval             = (var.enable_monitoring == true ? "60" : "0")
  monitoring_role_arn             = (var.enable_monitoring == true ? "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/rds-monitoring-role" : null)
  multi_az                        = false
  name                            = var.db_name
  parameter_group_name            = aws_db_parameter_group.db_parameter_group.id
  password                        = var.password
  replicate_source_db             = aws_db_instance.db_instance.id
  storage_encrypted               = var.storage_encrypted
  storage_type                    = var.storage_type
  username                        = var.username
  vpc_security_group_ids          = [aws_security_group.security_group.id]
  performance_insights_enabled    = var.performance_insights_enabled
  tags                            = var.tags
}
