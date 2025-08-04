locals {

}
# #####################################################
# # IAM Policies
# #####################################################
resource "aws_iam_policy" "policy" {
  for_each = toset(var.iam_policies)
  name     = "${local.prefix}-${each.key}" # DON't CHANGE THIS NAMING CONVENTION
  path     = "/"
  policy   = templatefile("${path.root}/resources/iam_policies/${terraform.workspace}/${each.key}.json", local.template_mapping)
  tags     = merge(local.common_tags)
}

resource "aws_iam_policy" "global_policy" {
  for_each = fileset("${path.root}/resources/iam_policies/global", "*.json")
  name     = "${local.prefix}-${replace(each.key, ".json", "")}" # DON't CHANGE THIS NAMING CONVENTION
  path     = "/"
  policy   = templatefile("${path.root}/resources/iam_policies/global/${each.value}", local.template_mapping)
  tags     = merge(local.common_tags)
}
