resource "aws_iam_role" "im-role" {
  name = "im-role"
  assume_role_policy = file("${path.module}/policies/assume-role-policy.json")
}
