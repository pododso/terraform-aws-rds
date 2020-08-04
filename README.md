# terraform-aws-rds
Module for managing RDS instances

## Features
* `has_replica` variable for creating a replica instance, using most of the configurations of the primary database instance
* `db_subnet_groups` included, only provide the subnet IDs
* `db_parameter_groups` included, provide the parameters as a list of objects with `key ` and `value`
* `security_group` included but no default ingress rules added

## Requirements
| Name      | Version   |
|-----------|-----------|
| terraform | >=0.12.24 |
| aws       | ~>3.0     |
