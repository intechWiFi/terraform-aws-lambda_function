/*--------------------------------------------------------------------
Create a role that the lambda function assumes when run
--------------------------------------------------------------------*/
resource "aws_iam_role" "assume" {
  name = "${var.id}-assume"
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
This is actually the same as the AWSLambdaBasicExecutionRole
--------------------------------------------------------------------*/
resource "aws_iam_role_policy_attachment" "logs" {
  role       = "${aws_iam_role.assume.name}"
  policy_arn = "${aws_iam_policy.logs.arn}"
}

resource "aws_iam_policy" "logs" {
  name   = "${var.id}-logs"
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

/*--------------------------------------------------------------------
Attach a policy allowing the function to manage EC2 ENIs
--------------------------------------------------------------------*/
resource "aws_iam_role_policy_attachment" "eni" {
  role       = "${aws_iam_role.assume.name}"
  policy_arn = "${aws_iam_policy.eni.arn}"
}

resource "aws_iam_policy" "eni" {
  name   = "${var.id}-eni"
  policy = "${data.aws_iam_policy_document.eni.json}"
}

data "aws_iam_policy_document" "eni" {
  statement {
    actions = [
      "ec2:DescribeNetworkInterfaces",
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }
}
