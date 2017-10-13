/*--------------------------------------------------------------------
Create the lambda function
--------------------------------------------------------------------*/
resource "aws_lambda_function" "function" {
  filename         = "${var.filename}"
  function_name    = "${var.function_name}"
  role             = "${var.role}"
  handler          = "${var.handler}"
  source_code_hash = "${base64sha256(file("${var.filename}"))}"
  runtime          = "${var.runtime}"
}
