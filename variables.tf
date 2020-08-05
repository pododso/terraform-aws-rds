## General

variable "tags" {
  type        = map(string)
  description = "Mapping of tags to apply to all resources in this module"
  default     = {}
}

variable "name" {
  type        = string
  description = "Name of the instance, also used in naming the other resources in this module"
}

## Security group

variable "vpc_id" {
  type        = string
  description = "The VPC ID where the instance/s will be deployed in"
}

## Parameter group

variable "family" {
  type        = string
  description = "Parameter group engine family of the instance"
}

variable "parameters" {
  type = list(object({
    key   = string
    value = string
  }))
  description = "Custom database parameters"
  default     = []
}

## Subnet group

variable "subnet_ids" {
  type        = list(string)
  description = "VPC Subnet IDs where the instance/s will be deployed in"
}

## DB Instance and Replica

variable "allocated_storage" {
  type        = string
  description = "Allocated storage size of the instance/s"
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Whether to allow major version upgrades in the instance/s"
  default     = false
}

variable "apply_immediately" {
  type        = bool
  description = "Whether to immediately apply database modifications"
  default     = false
}

variable "backup_retention_period" {
  type        = number
  description = "Number of days to retain instance snapshots"
  default     = null
}

variable "backup_window" {
  type        = string
  description = "Time window to perform database snapshots"
  default     = null
}

variable "delete_automated_backups" {
  type        = bool
  description = "Whether to delete automated snapshots when deleting the database"
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of cloudwatch logs to be exported, depends on engine"
  default     = []
}

variable "engine" {
  type        = string
  description = "Database engine to be used"
}

variable "engine_version" {
  type        = string
  description = "Database engine version to be used"
}

variable "instance_class" {
  type        = string
  description = "Instance class to be used"
}

variable "iops" {
  type        = number
  description = "IOPS count to be used if storage_type is set to 'io1'"
  default     = null
}

variable "maintenance_window" {
  type        = string
  description = "Time window to perform maintenance operations"
  default     = null
}

variable "enable_monitoring" {
  type        = bool
  description = "Whether to enable detailed monitoring in the instance/s"
  default     = false
}

variable "multi_az" {
  type        = bool
  description = "Whether to make the instance multi-az"
  default     = false
}

variable "db_name" {
  type        = string
  description = "Name of the default database to be created"
  default     = null
}

variable "password" {
  type        = string
  description = "Instance master password"
}

variable "port" {
  type        = number
  description = "Port to be used by the instance/s"
  default     = null
}

variable "snapshot_identifier" {
  type        = string
  description = "Snapshot identifier if the instance will be created from a snapshot"
  default     = null
}

variable "storage_encrypted" {
  type        = bool
  description = "Whether to apply encryption-at-rest to the database storage"
  default     = true
}

variable "storage_type" {
  type        = string
  description = "Storage type of the instance/s"
  default     = "gp2"
}

variable "username" {
  type        = string
  description = "Instance master username"
}

variable "performance_insights_enabled" {
  type        = bool
  description = "Whether to enable Performance Insights in the instance/s"
  default     = false
}

## DB Instance Replica

variable "has_replica" {
  type        = bool
  description = "Whether to create a replica instance, will follow most of the primary configurations"
  default     = false
}

variable "replica_backup_window" {
  type        = string
  description = "[Replica] Time window to perform database snapshots"
  default     = null
}

variable "replica_maintenance_window" {
  type        = string
  description = "[Replica] Time window to perform maintenance operations"
  default     = null
}
