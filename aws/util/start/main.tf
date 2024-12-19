resource "aws_iam_user" "start" {
  name = "${var.tags.lab_id}-start"
  path = "/labs/${var.lab_category}/${var.lab_name}/"

  tags = {
    tag-key = var.tags.lab_id
  }
}

resource "aws_iam_access_key" "start" {
  user = aws_iam_user.start.name
}