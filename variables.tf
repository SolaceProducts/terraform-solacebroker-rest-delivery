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

variable "authentication_aws_access_key_id" {
  description = "The AWS access key id."
  type        = string
  default     = null
}

variable "authentication_aws_region" {
  description = "The AWS region id."
  type        = string
  default     = null
}

variable "authentication_aws_secret_access_key" {
  description = "The AWS secret access key."
  type        = string
  default     = null
  sensitive   = true
}

variable "authentication_aws_service" {
  description = "The AWS service id."
  type        = string
  default     = null
}

variable "authentication_client_cert_content" {
  description = "The PEM formatted content for the client certificate that the REST Consumer will present to the REST host."
  type        = string
  default     = null
  sensitive   = true
}

variable "authentication_client_cert_password" {
  description = "The password for the client certificate."
  type        = string
  default     = null
  sensitive   = true
}

variable "authentication_http_basic_password" {
  description = "The password for the username."
  type        = string
  default     = null
  sensitive   = true
}

variable "authentication_http_basic_username" {
  description = "The username that the REST Consumer will use to login to the REST host."
  type        = string
  default     = null
}

variable "authentication_http_header_name" {
  description = "The authentication header name."
  type        = string
  default     = null
}

variable "authentication_http_header_value" {
  description = "The authentication header value."
  type        = string
  default     = null
  sensitive   = true
}

variable "authentication_oauth_client_id" {
  description = "The OAuth client ID."
  type        = string
  default     = null
}

variable "authentication_oauth_client_scope" {
  description = "The OAuth scope."
  type        = string
  default     = null
}

variable "authentication_oauth_client_secret" {
  description = "The OAuth client secret."
  type        = string
  default     = null
  sensitive   = true
}

variable "authentication_oauth_client_token_endpoint" {
  description = "The OAuth token endpoint URL that the REST Consumer will use to request a token for login to the REST host."
  type        = string
  default     = null
}

variable "authentication_oauth_client_token_expiry_default" {
  description = "The default expiry time for a token, in seconds."
  type        = number
  default     = null
}

variable "authentication_oauth_jwt_secret_key" {
  description = "The OAuth secret key used to sign the token request JWT."
  type        = string
  default     = null
  sensitive   = true
}

variable "authentication_oauth_jwt_token_endpoint" {
  description = "The OAuth token endpoint URL that the REST Consumer will use to request a token for login to the REST host."
  type        = string
  default     = null
}

variable "authentication_oauth_jwt_token_expiry_default" {
  description = "The default expiry time for a token, in seconds."
  type        = number
  default     = null
}

variable "authentication_scheme" {
  description = "The authentication scheme used by the REST Consumer to login to the REST host."
  type        = string
  default     = null
}

variable "client_profile_name" {
  description = "The Client Profile of the REST Delivery Point."
  type        = string
  default     = null
}

variable "enabled" {
  description = "Enable or disable the REST Delivery Point."
  type        = bool
  default     = null
}

variable "gateway_replace_target_authority_enabled" {
  description = "Enable or disable whether the authority for the request-target is replaced with that configured for the REST Consumer remote."
  type        = bool
  default     = null
}

variable "http_method" {
  description = "The HTTP method to use (POST or PUT)."
  type        = string
  default     = null
}

variable "local_interface" {
  description = "The interface that will be used for all outgoing connections associated with the REST Consumer."
  type        = string
  default     = null
}

variable "max_post_wait_time" {
  description = "The maximum amount of time (in seconds) to wait for an HTTP POST response from the REST Consumer."
  type        = number
  default     = null
}

variable "outgoing_connection_count" {
  description = "The number of concurrent TCP connections open to the REST Consumer."
  type        = number
  default     = null
}

variable "proxy_name" {
  description = "The name of the proxy to use."
  type        = string
  default     = null
}

variable "remote_host" {
  description = "The IP address or DNS name to which the broker is to connect to deliver messages for the REST Consumer."
  type        = string
  default     = null
}

variable "remote_port" {
  description = "The port associated with the host of the REST Consumer."
  type        = number
  default     = null
}

variable "request_target_evaluation" {
  description = "The type of evaluation to perform on the request target."
  type        = string
  default     = null
}

variable "retry_delay" {
  description = "The number of seconds that must pass before retrying the remote REST Consumer connection."
  type        = number
  default     = null
}

variable "service" {
  description = "The name of the service that this REST Delivery Point connects to."
  type        = string
  default     = null
}

variable "tls_cipher_suite_list" {
  description = "The colon-separated list of cipher suites the REST Consumer uses in its encrypted connection."
  type        = string
  default     = null
}

variable "tls_enabled" {
  description = "Enable or disable encryption (TLS) for the REST Consumer."
  type        = bool
  default     = null
}

variable "vendor" {
  description = "The name of the vendor that this REST Delivery Point connects to."
  type        = string
  default     = null
}


variable "request_header" {
  type = set(object({
    header_name  = string
    header_value = optional(string)
  }))
  description = "A request header to be added to the HTTP request."
  default     = []
}

variable "oauth_jwt_claim" {
  type = set(object({
    oauth_jwt_claim_name  = string
    oauth_jwt_claim_value = string
  }))
  description = "A Claim is added to the JWT sent to the OAuth token request endpoint."
  default     = []
}

