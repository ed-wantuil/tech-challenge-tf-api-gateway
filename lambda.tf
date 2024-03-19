data "archive_file" "auth" {
  output_path = "lambda/auth.py"
  type = "zip"
  source_file = "lambda/auth.py"
}

resource "aws_lambda_function" "auth" {
  function_name = "auth"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  role          = "arn:aws:iam::058264138215:role/LabRole"

  filename         = data.archive_file.auth.output_path
  source_code_hash = data.archive_file.auth.output_base64sha256
}

data "archive_file" "create" {
  output_path = "lambda/create.py"
  type = "zip"
  source_file = "lambda/create.py"
}

resource "aws_lambda_function" "create" {
  function_name = "create"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  role          = "arn:aws:iam::058264138215:role/LabRole"

  filename         = data.archive_file.create.output_path
  source_code_hash = data.archive_file.create.output_base64sha256
}
