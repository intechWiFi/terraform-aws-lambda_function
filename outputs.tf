output "lambda_function_arn" {
  value = "${aws_lambda_function.logzio_shipper.arn}"
}

output "lambda_function_name" {
  value = "${aws_lambda_function.logzio_shipper.function_name}"
}
