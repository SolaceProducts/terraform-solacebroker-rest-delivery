locals {
  tls           = startswith(lower(var.url), "https:")
  slashSplit    = split("/", var.url)
  hostPortSplit = split(":", local.slashSplit[2])
  host          = local.hostPortSplit[0]
  port          = length(local.hostPortSplit) == 2 ? tonumber(local.hostPortSplit[1]) : (local.tls ? 443 : 80)
  path          = "/${join("/", slice(local.slashSplit, 3, length(local.slashSplit)))}"
}

resource "solacebroker_msg_vpn_rest_delivery_point" "main" {
  msg_vpn_name             = var.msg_vpn_name
  rest_delivery_point_name = var.rest_delivery_point_name
  enabled                  = var.enabled

  client_profile_name = var.client_profile_name
  service             = var.service
  vendor              = var.vendor
}

resource "solacebroker_msg_vpn_rest_delivery_point_rest_consumer" "main" {
  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  enabled                  = solacebroker_msg_vpn_rest_delivery_point.main.enabled
  rest_consumer_name       = var.rest_consumer_name != null ? var.rest_consumer_name : "consumer"
  remote_host              = local.host
  remote_port              = local.port
  tls_enabled              = local.tls

  authentication_aws_access_key_id                 = var.authentication_aws_access_key_id
  authentication_aws_region                        = var.authentication_aws_region
  authentication_aws_secret_access_key             = var.authentication_aws_secret_access_key
  authentication_aws_service                       = var.authentication_aws_service
  authentication_client_cert_content               = var.authentication_client_cert_content
  authentication_client_cert_password              = var.authentication_client_cert_password
  authentication_http_basic_password               = var.authentication_http_basic_password
  authentication_http_basic_username               = var.authentication_http_basic_username
  authentication_http_header_name                  = var.authentication_http_header_name
  authentication_http_header_value                 = var.authentication_http_header_value
  authentication_oauth_client_id                   = var.authentication_oauth_client_id
  authentication_oauth_client_scope                = var.authentication_oauth_client_scope
  authentication_oauth_client_secret               = var.authentication_oauth_client_secret
  authentication_oauth_client_token_endpoint       = var.authentication_oauth_client_token_endpoint
  authentication_oauth_client_token_expiry_default = var.authentication_oauth_client_token_expiry_default
  authentication_oauth_jwt_secret_key              = var.authentication_oauth_jwt_secret_key
  authentication_oauth_jwt_token_endpoint          = var.authentication_oauth_jwt_token_endpoint
  authentication_oauth_jwt_token_expiry_default    = var.authentication_oauth_jwt_token_expiry_default
  authentication_scheme                            = var.authentication_scheme
  http_method                                      = var.http_method
  local_interface                                  = var.local_interface
  max_post_wait_time                               = var.max_post_wait_time
  outgoing_connection_count                        = var.outgoing_connection_count
  proxy_name                                       = var.proxy_name
  retry_delay                                      = var.retry_delay
  tls_cipher_suite_list                            = var.tls_cipher_suite_list
}

resource "solacebroker_msg_vpn_rest_delivery_point_queue_binding" "main" {
  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  queue_binding_name       = var.queue_name
  post_request_target      = local.path

  gateway_replace_target_authority_enabled = var.gateway_replace_target_authority_enabled
  request_target_evaluation                = var.request_target_evaluation
}

resource "solacebroker_msg_vpn_rest_delivery_point_queue_binding_request_header" "main" {

  for_each = { for v in var.request_headers : v.header_name => v }

  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  queue_binding_name       = solacebroker_msg_vpn_rest_delivery_point_queue_binding.main.queue_binding_name

  header_name  = each.value.header_name
  header_value = each.value.header_value
}

resource "solacebroker_msg_vpn_rest_delivery_point_rest_consumer_oauth_jwt_claim" "main" {
  for_each = { for v in var.oauth_jwt_claims : v.oauth_jwt_claim_name => v }

  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  rest_consumer_name       = solacebroker_msg_vpn_rest_delivery_point_rest_consumer.main.rest_consumer_name

  oauth_jwt_claim_name  = each.value.oauth_jwt_claim_name
  oauth_jwt_claim_value = each.value.oauth_jwt_claim_value
}

