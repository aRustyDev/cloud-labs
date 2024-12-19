module "via_assumeRole" {
  source = "./via_assumeRole"
  count  = var.target_lab == "via_assumeRole" ? 1 : 0

  time = var.time
  tags = var.tags
}

# module "via_attachUserPolicy" {
#   source = "./via_attachUserPolicy"
#   count  = var.target_lab == "via_attachUserPolicy" ? 1 : 0
#   tags = var.tags
# }

# module "via_githubAction" {
#   source = "./via_githubAction"
#   count  = var.target_lab == "via_githubAction" ? 1 : 0
#   tags = var.tags
# }

# module "via_policyVerUpdate" {
#   source = "./via_policyVerUpdate"
#   count  = var.target_lab == "via_policyVerUpdate" ? 1 : 0
#   tags = var.tags
# }