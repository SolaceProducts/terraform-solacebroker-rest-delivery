provider "solacebroker" {
  username = "admin"
  password = "admin"
  url      = "http://localhost:8080"
}

# The RDP requires a queue to bind to.
# Recommended: Use the queue-endpoint module to create the queue
# TODO: Uncomment the following block and replace the resource block once the queue-endpoint module is available
# module "rdp_queue" {
#   source = SolaceProducts/queue-endpoint/solacebroker
#
#   msg_vpn_name  = "default"
#   endpoint_type = "queue"
#   endpoint_name = "rdp_queue"
#
#   # The REST delivery point must have permission to consume messages from the queue
#   # — to achieve this, either the queue’s owner must be set to `#rdp/<rest_delivery_point_name>`
#   # owner = "#rdp/basic_rdp"
#   #   or the queue’s permissions for non-owner clients must be set to at least `consume` level access
#   permission = "consume"
#
#   # The queue must also be enabled for ingress and egress, which is the default for the rdp_queue module
# }
resource "solacebroker_msg_vpn_queue" "rdp_queue" {
  msg_vpn_name = "default"
  queue_name   = "rdp_queue"
  permission   = "consume"
  ingress_enabled = true
  egress_enabled = true
}

module "testrdp" {
  source                  = "../.."
  
  msg_vpn_name            = "default"
  rest_delivery_point_name = "basic_rdp"
  url                     = "https://example.com/test"
  # queue_name              = module.rdp_queue.queue.queue_name
  queue_name              = solacebroker_msg_vpn_queue.rdp_queue.queue_name
  enabled                 = var.enabled

  # Example additional config required for proper OAuth setup
  # authentication_scheme = "oauth-jwt"
  # authentication_oauth_jwt_secret_key = "-----BEGIN PRIVATE KEY-----test-----END PRIVATE KEY-----\n"
  # authentication_oauth_jwt_token_endpoint = "https://www.googleapis.com/oauth2/v4/token"
  # authentication_oauth_jwt_token_expiry_default = "3600"
  oauth_jwt_claims = [
    {
      oauth_jwt_claim_name  = "scope"
      oauth_jwt_claim_value =  "\"https://www.googleapis.com/auth/pubsub\""
    },
    {
      oauth_jwt_claim_name  = "iss"
      oauth_jwt_claim_value =  "\"111400995554822290197\""
    }
  ]
}

output "rdp" {
  value = module.testrdp.rest_delivery_point
}

output "consumer" {
  value = module.testrdp.rest_consumer
  sensitive = true
}

output "queue_binding" {
  value = module.testrdp.queue_binding
}
