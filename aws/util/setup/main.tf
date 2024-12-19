module "flags" {
  source = "../flags"

  lab_category    = var.lab_category
  lab_name        = var.lab_name
  flag_policy_arn = var.flag_policy_arn
  tags = {
    lab_id = var.tags.lab_id
  }
}

module "start_point" {
  source = "../start"

  lab_category = var.lab_category
  lab_name     = var.lab_name
  tags = {
    lab_id = var.tags.lab_id
  }
}

module "target_point" {
  source = "../target"

  lab_category = var.lab_category
  lab_name     = var.lab_name
  policy_json  = var.target_policy_json
  
  tags = {
    lab_id = var.tags.lab_id
  }
}