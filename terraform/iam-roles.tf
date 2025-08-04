# #####################################################
# # IAM ROLES
# #####################################################
locals {
  role_folder         = "${path.root}/resources/iam_roles/${terraform.workspace}"
  role_policies_files = fileset(local.role_folder, "*.json")
  role_prefix         = var.role_prefix == null ? local.prefix : var.role_prefix
  role_suffix         = var.role_suffix == null ? local.suffix : var.role_suffix

  template_mapping = {
    region         = var.region
    aws_account_id = local.account_id
    partition      = data.aws_partition.current.partition
  }

  role_naming_convention = {
    for role in var.iam_roles :
    role => {
      name = format("%s%s%s", local.role_prefix, role, local.role_suffix)

      role_policies = jsondecode(templatefile("${local.role_folder}/${role}.json", local.template_mapping))["role_policies"]

      assume_role_policies = jsondecode(templatefile("${local.role_folder}/${role}.json", local.template_mapping))["assume_role_policies"]

      max_session_duration = lookup(jsondecode(templatefile("${local.role_folder}/${role}.json", local.template_mapping)), "max_session_duration", null)

      managed_policy_arns = lookup(jsondecode(templatefile("${local.role_folder}/${role}.json", local.template_mapping)), "managed_policy_arns", [])


    } if contains(local.role_policies_files, "${role}.json")
  }

  global_role_folder                        = "${path.root}/resources/iam_roles/global"
  global_role_policies_files_with_extension = fileset(local.global_role_folder, "*.json")

  global_role_policies_files = [for roles in local.global_role_policies_files_with_extension : replace(roles, ".json", "")]

  global_role_naming_convention = {
    for role in local.global_role_policies_files :
    role => {
      name = format("%s%s%s", local.role_prefix, role, local.role_suffix)

      role_policies = jsondecode(templatefile("${local.global_role_folder}/${role}.json", local.template_mapping))["role_policies"]

      assume_role_policies = jsondecode(templatefile("${local.global_role_folder}/${role}.json", local.template_mapping))["assume_role_policies"]

      max_session_duration = lookup(jsondecode(templatefile("${local.global_role_folder}/${role}.json", local.template_mapping)), "max_session_duration", null)

      managed_policy_arns = lookup(jsondecode(templatefile("${local.global_role_folder}/${role}.json", local.template_mapping)), "managed_policy_arns", [])

    }
  }


  account_level_based_on_iam_policy_roles = [for iam_policy in var.iam_policies : iam_policy if contains(var.exclude_role_creation_based_on_iam_policies, iam_policy) == false]
}

resource "aws_iam_role" "master_roles" {
  for_each           = merge(local.role_naming_convention, local.global_role_naming_convention)
  name               = each.value.name
  assume_role_policy = jsonencode(each.value.assume_role_policies)

  managed_policy_arns = each.value.managed_policy_arns

  inline_policy {
    name   = each.value.name
    policy = jsonencode(each.value.role_policies)
  }

  tags = merge(local.common_tags)

  max_session_duration = each.value.max_session_duration
}
