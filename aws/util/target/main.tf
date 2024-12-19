resource "aws_iam_user" "target" {
  name = "${var.tags.lab_id}-target"
  path = "/labs/${var.lab_category}/${var.lab_name}/"

  tags = {
    tag-key = var.tags.lab_id
  }
}

resource "aws_iam_role" "target" {
  name = "${var.tags.lab_id}-target"
  path = "/labs/${var.lab_category}/${var.lab_name}/"

  assume_role_policy = var.policy_json

  tags = {
    tag-key = var.tags.lab_id
  }
}