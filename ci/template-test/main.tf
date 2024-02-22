provider "solacebroker" {
  username = "admin"
  password = "admin"
  url      = "http://localhost:8080"
}

module "testrdp" {
  source                  = "../../internal/gen-template"
  
  msg_vpn_name            = "default"
  queue_name              = "my_queue"
  url                     = "http://example.com/$${msgId()}"
  rest_delivery_point_name = "my_rdp"
  rest_consumer_name      = "my_consumer"
  request_header = [
    {
      header_name  = "header1"
      header_value = "$${uuid()}"
    },
    {
      header_name  = "header2"
      header_value = "value2"
    }
  ]
  oauth_jwt_claim = [
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

