data "aws_vpc" "selected" {
  id = var.vpc_id
}

locals {
  name     = var.name
  vpc_name = try(data.aws_vpc.selected.tags["Name"], "default")

  tags = merge(
    { "Name" = format("tf-elasticache-%s-%s", local.name, local.vpc_name) },
    var.tags
  )
}

resource "aws_elasticache_subnet_group" "valkey_subnet_group" {
  name        = local.name
  description = format("Subnet group for ElastiCache %s", local.name)
  subnet_ids  = var.subnets
  tags        = local.tags
}

resource "aws_elasticache_replication_group" "valkey_replication" {
  count                       = var.engine == "valkey" ? 1 : 0
  replication_group_id        = local.name
  description                 = format("Terraform-managed ElastiCache replication group for %s", local.name)
  engine                      = "valkey"
  engine_version              = var.engine_version
  node_type                   = var.node_type
  num_cache_clusters          = 2
  automatic_failover_enabled  = var.automatic_failover_enabled
  multi_az_enabled            = var.multi_az_enabled
  apply_immediately           = var.apply_immediately
  transit_encryption_enabled  = true
  transit_encryption_mode     = "preferred"
  at_rest_encryption_enabled  = true
  maintenance_window          = var.maintenance_window
  port                        = var.port

  subnet_group_name           = aws_elasticache_subnet_group.valkey_subnet_group.name
  security_group_ids          = [aws_security_group.elasticache_sg.id]
  parameter_group_name        = var.parameter_group_name

  tags = local.tags
}
