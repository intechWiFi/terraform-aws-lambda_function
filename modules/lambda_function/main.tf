/*--------------------------------------------------------------------
Create the lambda function
--------------------------------------------------------------------*/
resource "aws_lambda_function" "function" {
  filename         = "${var.filename}"
  function_name    = "${var.function_name}"
  handler          = "${var.handler}"
  role             = "${var.role}"
  runtime          = "${var.runtime}"
  source_code_hash = "${base64sha256(file("${var.filename}"))}"

  vpc_config = {
    security_group_ids = ["${var.security_group_ids}"]
    subnet_ids         = ["${var.subnet_ids}"]
  }
}
