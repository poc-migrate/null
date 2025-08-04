data "aws_vpc" "this" {
  id = local.current_account_network_infos.selected_vpc_id
}

data "aws_subnet" "private" {
  for_each = toset(local.current_account_network_infos.selected_private_subnets)
  id       = each.value
}
