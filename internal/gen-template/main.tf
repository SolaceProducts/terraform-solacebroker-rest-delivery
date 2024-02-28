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

  #AutoAddAttributes #EnableCommonVariables
}

resource "solacebroker_msg_vpn_rest_delivery_point_rest_consumer" "main" {
  msg_vpn_name                                     = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name                         = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  enabled                                          = solacebroker_msg_vpn_rest_delivery_point.main.enabled
  rest_consumer_name                               = var.rest_consumer_name != null ? var.rest_consumer_name : "consumer"
  remote_host                                      = local.host
  remote_port                                      = local.port
  tls_enabled                                      = local.tls

  #AutoAddAttributes #EnableCommonVariables
}

resource "solacebroker_msg_vpn_rest_delivery_point_queue_binding" "main" {
  msg_vpn_name                             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name                 = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  queue_binding_name                       = var.queue_name
  post_request_target                      = local.path

  #AutoAddAttributes #EnableCommonVariables
}

resource "solacebroker_msg_vpn_rest_delivery_point_queue_binding_request_header" "main" {

  for_each = {for v in var.request_headers : v.header_name => v}

  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  queue_binding_name       = solacebroker_msg_vpn_rest_delivery_point_queue_binding.main.queue_binding_name

  header_name              = each.value.header_name
  header_value             = each.value.header_value
}

resource "solacebroker_msg_vpn_rest_delivery_point_rest_consumer_oauth_jwt_claim" "main" {
  for_each = {for v in var.oauth_jwt_claims : v.oauth_jwt_claim_name => v}

  msg_vpn_name             = solacebroker_msg_vpn_rest_delivery_point.main.msg_vpn_name
  rest_delivery_point_name = solacebroker_msg_vpn_rest_delivery_point.main.rest_delivery_point_name
  rest_consumer_name       = solacebroker_msg_vpn_rest_delivery_point_rest_consumer.main.rest_consumer_name

  oauth_jwt_claim_name     = each.value.oauth_jwt_claim_name
  oauth_jwt_claim_value    = each.value.oauth_jwt_claim_value
}
