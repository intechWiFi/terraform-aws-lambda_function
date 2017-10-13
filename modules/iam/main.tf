/*--------------------------------------------------------------------
Create a role that the lambda function assumes when run
--------------------------------------------------------------------*/
resource "aws_iam_role" "assume" {
  name = "${var.function_name}-assume"
  path = "/"

  assume_role_policy = "${data.aws_iam_policy_document.assume.json}"
}

data "aws_iam_policy_document" "assume" {
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
resource "aws_iam_role_policy_attachment" "logs" {
  role       = "${aws_iam_role.assume.name}"
  policy_arn = "${aws_iam_policy.logs.arn}"
}

resource "aws_iam_policy" "logs" {
  name   = "${var.function_name}-logs"
  policy = "${data.aws_iam_policy_document.logs.json}"
}

data "aws_iam_policy_document" "logs" {
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
