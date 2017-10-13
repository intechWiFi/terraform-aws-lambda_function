/*--------------------------------------------------------------------
Create a role that the lambda function assumes when run
--------------------------------------------------------------------*/
resource "aws_iam_role" "lambda_function_assume" {
  name = "${var.function_name}-assume"
  path = "/"

  assume_role_policy = "${data.aws_iam_policy_document.lambda_function_assume.json}"
}

data "aws_iam_policy_document" "lambda_function_assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

/*--------------------------------------------------------------------
Attach a policy allowing the function to write cloudwatch logs
--------------------------------------------------------------------*/
resource "aws_iam_role_policy_attachment" "write_cloudwatch_logs" {
  role       = "${aws_iam_role.lambda_function_assume.name}"
  policy_arn = "${aws_iam_policy.write_cloudwatch_logs.arn}"
}

resource "aws_iam_policy" "write_cloudwatch_logs" {
  name   = "${var.function_name}-write-logs"
  policy = "${data.aws_iam_policy_document.write_cloudwatch_logs.json}"
}

data "aws_iam_policy_document" "write_cloudwatch_logs" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

/*--------------------------------------------------------------------
Attach a policy allowing the function to copy DB snapshots
--------------------------------------------------------------------*/
resource "aws_iam_role_policy_attachment" "copy_db_snapshot" {
  role       = "${aws_iam_role.lambda_function_assume.name}"
  policy_arn = "${aws_iam_policy.kms_decrypt.arn}"
}

resource "aws_iam_policy" "copy_db_snapshot" {
  name   = "${var.function_name}-copy_db_snapshot"
  policy = "${data.aws_iam_policy_document.kms_decrypt.json}"
}

data "aws_iam_policy_document" "copy_db_snapshot" {
  statement {
    actions = [
      "rds:CopyDBSnapshot",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }
}

/*--------------------------------------------------------------------
Create the lambda function
--------------------------------------------------------------------*/
resource "aws_lambda_function" "function" {
  filename         = "${path.module}/files/${local.archive_name}"
  function_name    = "${var.function_name}"
  role             = "${aws_iam_role.lambda_function_assume.arn}"
  handler          = "index.handler"
  source_code_hash = "${base64sha256(file("${path.module}/files/${local.archive_name}"))}"
  runtime          = "nodejs6.10"
}
