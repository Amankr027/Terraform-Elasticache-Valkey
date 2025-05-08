variable "vpc_id" {
  description = "The VPC ID where the ElastiCache cluster will be deployed."
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs to use for ElastiCache subnet group."
  type        = list(string)
}



variable "node_type" {
  description = "The node type for ElastiCache."
  type        = string
  default     = "cache.t3.medium"
}

variable "engine_version" {
  description = "The version of the Valkey engine."
  type        = string
  default     = "7.2"
}

variable "automatic_failover_enabled" {
  description = "Whether automatic failover is enabled."
  type        = bool
  default     = true
}

variable "multi_az_enabled" {
  description = "Whether Multi-AZ is enabled."
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Whether changes should be applied immediately."
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "The parameter group name for ElastiCache."
  type        = string
  default     = "default.valkey7"
}

variable "port" {
  description = "Port number for Redis (Valkey)."
  type        = number
  default     = 6379
}

variable "maintenance_window" {
  description = "Maintenance window for the ElastiCache cluster."
  type        = string
  default     = "sun:05:00-sun:09:00"
}

variable "name" {
  description = "Base name used in resource naming."
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
