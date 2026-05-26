resource "aws_nat_gateway" "this" {
  count = module.this.enabled ? 1 : 0

  allocation_id     = var.allocation_id
  subnet_id         = var.subnet_id
  connectivity_type = var.connectivity_type

  tags = merge(module.this.tags, { Name = module.this.id })
}
