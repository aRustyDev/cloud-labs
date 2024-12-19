locals {
  policy_arn_prefix = "arn:aws:iam::${local.account_id}:policy/${local.iam_path}"
  role_arn_prefix   = "arn:aws:iam::${local.account_id}:role/${local.iam_path}"
  iam_path          = "labs/${local.lab_category}/${local.lab_name}/${var.tags.lab_id}"
  policy = {
    start = templatefile("${path.module}/policy.start.json", {
      TargetRoleArn   = "${local.role_arn_prefix}/target"
      TargetPolicyArn = "${local.policy_arn_prefix}/target"
      StartPolicyArn  = "${local.policy_arn_prefix}/start"
      OrigUserArn     = "arn:aws:iam::${local.account_id}:user/${local.user_name}"
      LabId           = local.tags.lab_id
    })
    target = templatefile("${path.module}/policy.target.json", {
      TimeNow    = var.time.now
      TimeEnd    = var.time.end
      SecretArn  = module.setup.secret_arn
      Region     = local.region
      Account    = local.account_id
    })
    boundary = templatefile("${path.module}/policy.boundary.json", {
      AccountId     = local.account_id # TODO: Might need to add ability to specify this?
      Region        = local.region
      RoleName      = "${local.tags.lab_id}-${local.lab_category}-${local.lab_name}"
      SessionName   = "${local.tags.lab_id}-${local.lab_category}-${local.lab_name}"
      OrigUserArn   = "arn:aws:iam::${local.account_id}:user/${local.user_name}"
      TargetRoleArn = "${local.role_arn_prefix}/target"
      FlagArn       = module.setup.flag_arn
      TimeNow       = var.time.now
      TimeEnd       = var.time.end
    })
  }
  account_id   = data.aws_caller_identity.current.account_id
  user_name    = data.aws_caller_identity.current.user_id
  region       = data.aws_region.current.name
  lab_category = "privesc"
  lab_name     = "via_assumeRole"
  tags = merge(
    var.tags,
    {}
  )
}