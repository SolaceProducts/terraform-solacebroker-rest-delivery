provider "solacebroker" {
  username = "admin"
  password = "admin"
  url      = "http://localhost:8080"
}

resource "solacebroker_msg_vpn_queue" "myqueue" {
  msg_vpn_name = "default"
  queue_name   = "rdp_queue"
  permission   = "consume"
}

module "testrdp" {
  source                  = "../../internal/gen-template"
  
  msg_vpn_name            = "default"
  queue_name              = solacebroker_msg_vpn_queue.myqueue.queue_name
  url                     = "http://example.com/$${msgId()}"
  rest_delivery_point_name = "my_rdp"
  enabled = false
  request_headers = [
    {
      header_name  = "header1"
      header_value = "$${uuid()}"
    },
    {
      header_name  = "header2"
      header_value = "value2"
    }
  ]
  protected_request_headers = [
    {
      header_name  = "protected_header1"
      header_value = "protected_value1"
    },
    {
      header_name  = "protected_header2"
      header_value = "protected_value2"
    }
  ]
  oauth_jwt_claims = [
    {
      oauth_jwt_claim_name  = "scope"
      oauth_jwt_claim_value =  "\"https://www.googleapis.com/auth/pubsub\""
    },
    {
      oauth_jwt_claim_name  = "aud"
      oauth_jwt_claim_value =  "\"https://www.googleapis.com/oauth2/v4/token\""
    },
    {
      oauth_jwt_claim_name  = "iss"
      oauth_jwt_claim_value =  "\"111400995554822290197\""
    },
    {
      oauth_jwt_claim_name  = "sub"
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

output "request_headers" {
  value = module.testrdp.request_headers
}

output "protected_request_headers" {
  value = module.testrdp.protected_request_headers
  sensitive = true
}

output "oauth_jwt_claims" {
  value = module.testrdp.oauth_jwt_claims
}

module "testrdp2" {
  source                  = "../../internal/gen-template"
  
  msg_vpn_name            = "default"
  queue_name              = solacebroker_msg_vpn_queue.myqueue.queue_name
  url                     = "http://example.com/$${msgId()}"
  rest_delivery_point_name = "my_rdp2"
  request_headers = module.testrdp.request_headers
  protected_request_headers = module.testrdp.protected_request_headers
}