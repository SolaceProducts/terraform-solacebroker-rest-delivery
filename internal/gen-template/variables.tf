# Input variable definitions

# Required variables

variable "url" {
  description = "The URL that the messages should be delivered to. The path portion of the URL may contain substitution expressions, unless `."
  type        = string
}

variable "msg_vpn_name" {
  description = "The name of the Message VPN"
  type        = string
}

variable "rest_delivery_point_name" {
  type        = string
  description = "The name of the REST Delivery Point."
}

variable "queue_name" {
  type        = string
  description = "The name of the queue to bind to. The REST Delivery Point must also have permission to consume messages from the queue — to achieve this, the queue’s owner must be set to #rdp/<rdp-name> or the queue’s permissions for non-owner clients must be set to at least `consume` level access."
}

# Optional variables

variable "rest_consumer_name" {
  type        = string
  description = "The name of the REST Consumer."
  default     = null
}

#AutoAddAttributes

variable "request_header" {
  type        = set(object({
                  header_name  = string
                  header_value = optional(string)
                }))
  description = "A request header to be added to the HTTP request."
  default     = []
}

variable "oauth_jwt_claim" {
  type        = set(object({
                  oauth_jwt_claim_name  = string
                  oauth_jwt_claim_value = string
                }))
  description = "A Claim is added to the JWT sent to the OAuth token request endpoint."
  default     = []
}
