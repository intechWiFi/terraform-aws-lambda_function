#########################
# Get current AWS Region
#########################
data "aws_region" "current" {
  current = "true"
}

# IAM role/policies
####################
module "iam" {
  source = "./modules/iam"

  id = "${var.function_name}-${data.aws_region.current.name}"
}

##################
# Lambda function
##################
module "lambda_function" {
  source = "./modules/lambda_function"

  filename           = "${var.filename}"
  function_name      = "${var.function_name}"
  handler            = "${var.handler}"
  role               = "${module.iam.role}"
  runtime            = "${var.runtime}"
  security_group_ids = "${var.security_group_ids}"
  subnet_ids         = "${var.subnet_ids}"
  tags               = "${var.tags}"
}
