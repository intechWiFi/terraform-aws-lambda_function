#########################
# Get current AWS Region
#########################
data "aws_region" "current" {}

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

  filename      = "${var.filename}"
  function_name = "${var.function_name}"
  handler       = "${var.handler}"
  role          = "${module.iam.role}"
  runtime       = "${var.runtime}"
  tags          = "${var.tags}"
  vpc_config    = "${var.vpc_config}"
}
