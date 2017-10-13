output "role" {
  value = "${aws_iam_role.assume.arn}"
}

output "role_name" {
  value = "${aws_iam_role.assume.name}"
}
