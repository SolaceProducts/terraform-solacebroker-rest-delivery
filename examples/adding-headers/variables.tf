  variable "protected_request_headers" {
    type    = list(object({
      header_name  = string
      header_value = string
    }))
    default = []
  }
