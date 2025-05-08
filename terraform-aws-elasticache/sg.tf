resource "aws_security_group" "elasticache_sg" {
  name        = format("tf-elasticache-sg-%s", var.name)
  description = format("Terraform-managed SG for ElastiCache %s", var.name)
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "Allow Redis"
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  tags = merge(
    tomap({ "Name" = format("tf-elasticache-sg-%s", var.name) }),
    var.tags
  )
}
