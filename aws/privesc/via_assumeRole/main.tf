module "setup" {
  source = "../../util/setup"

  lab_category    = local.lab_category
  lab_name        = local.lab_name
  flag_policy_arn = aws_iam_policy.target.arn
  target_policy_json = local.policy.target
  tags = {
    lab_id = var.tags.lab_id
  }
}

resource "aws_iam_policy" "start" {
  name        = "start"
  path        = "/${local.iam_path}/"
  description = "Policy for ${local.lab_category} ${local.lab_name} lab"
  policy      = local.policy.start

  tags = {
    lab_id = var.tags.lab_id
  }
}

resource "aws_iam_policy" "target" {
  name        = "target"
  path        = "/${local.iam_path}/"
  description = "Policy for ${local.lab_category} ${local.lab_name} lab"
  policy      = local.policy.target

  tags = {
    lab_id = var.tags.lab_id
  }
}

resource "aws_iam_policy" "boundary" {
  name        = "permissions-boundary"
  path        = "/${local.iam_path}/"
  description = "Permissions Boundary policy for ${local.lab_category} ${local.lab_name} lab"
  policy      = local.policy.boundary

  tags = {
    lab_id = var.tags.lab_id
  }
}