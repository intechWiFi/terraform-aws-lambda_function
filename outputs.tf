output "arn" {
  value = "${module.lambda_function.arn}"
}

output "role" {
  value = "${module.iam.role}"
}

output "role_name" {
  value = "${module.iam.role_name}"
}
