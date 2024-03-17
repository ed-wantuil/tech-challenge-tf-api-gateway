resource "aws_api_gateway_rest_api" "api" {
  name        = "TechChallengeAPI"
  description = "API para o Tech Challenge"
}

resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name                             = "CognitoAuthorizer"
  type                             = "COGNITO_USER_POOLS"
  rest_api_id                      = aws_api_gateway_rest_api.api.id
  identity_source                  = "method.request.header.Authorization"
  provider_arns                    = [aws_cognito_user_pool.techchallenge-pool.arn]
}

resource "aws_api_gateway_resource" "product_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "product"
}

resource "aws_api_gateway_method" "product_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.product_resource.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "product_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.product_resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "product_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.product_resource.id
  http_method = aws_api_gateway_method.product_get.http_method

  type             = "HTTP"
  integration_http_method = "GET"
  uri              = "http://aafd7edcf68c34e1eaa7e5f945bcacc5-75308363.us-east-1.elb.amazonaws.com:8080/produto" # Substitua pela URI real do seu backend
}

resource "aws_api_gateway_integration" "product_post_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.product_resource.id
  http_method = aws_api_gateway_method.product_post.http_method

  type             = "HTTP"
  integration_http_method = "POST"
  uri              = "http://aafd7edcf68c34e1eaa7e5f945bcacc5-75308363.us-east-1.elb.amazonaws.com:8080/produto" # Substitua pela URI real do seu backend
}

resource "aws_api_gateway_resource" "checkout_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "checkout"
}

resource "aws_api_gateway_method" "checkout_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.checkout_resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "checkout_post_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.checkout_resource.id
  http_method = aws_api_gateway_method.checkout_post.http_method

  type = "HTTP"
  integration_http_method = "POST"
  uri = "http://aafd7edcf68c34e1eaa7e5f945bcacc5-75308363.us-east-1.elb.amazonaws.com:8080/checkout"
}

resource "aws_api_gateway_resource" "customer_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "customer"
}

resource "aws_api_gateway_method" "customer_get" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.customer_resource.id
  http_method   = "GET"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_method" "customer_post" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.customer_resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "customer_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.customer_resource.id
  http_method = aws_api_gateway_method.customer_get.http_method

  type = "HTTP"
  integration_http_method = "GET"
  uri = "http://aafd7edcf68c34e1eaa7e5f945bcacc5-75308363.us-east-1.elb.amazonaws.com:8080/customer"
}

resource "aws_api_gateway_integration" "customer_post_integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.customer_resource.id
  http_method = aws_api_gateway_method.customer_post.http_method

  type = "HTTP"
  integration_http_method = "POST"
  uri = "http://aafd7edcf68c34e1eaa7e5f945bcacc5-75308363.us-east-1.elb.amazonaws.com:8080/customer"
}
#
#resource "aws_api_gateway_resource" "order_update_delivery_status_resource" {
#  rest_api_id = aws_api_gateway_rest_api.api.id
#  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
#  path_part   = "update-delivery-status"
#}
#
#resource "aws_api_gateway_method" "order_update_delivery_status_patch" {
#  rest_api_id   = aws_api_gateway_rest_api.api.id
#  resource_id   = aws_api_gateway_resource.order_update_delivery_status_resource.id
#  http_method   = "PATCH"
#  authorization = "COGNITO_USER_POOLS"
#  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
#}
#
#resource "aws_api_gateway_integration" "order_update_delivery_status_patch_integration" {
#  rest_api_id = aws_api_gateway_rest_api.api.id
#  resource_id = aws_api_gateway_resource.order_update_delivery_status_resource.id
#  http_method = aws_api_gateway_method.order_update_delivery_status_patch.http_method
#
#  type = "HTTP"
#  integration_http_method = "PATCH"
#  uri = "http://aafd7edcf68c34e1eaa7e5f945bcacc5-75308363.us-east-1.elb.amazonaws.com:8080/order/update-delivery-status"
#}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.product_get_integration,
    aws_api_gateway_integration.product_post_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "v1"
}

