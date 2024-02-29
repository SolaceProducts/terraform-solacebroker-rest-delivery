# Solace PubSub+ Software Event Broker REST Delivery Terraform Module

Terraform module to support the setup of a [REST consumer](https://docs.solace.com/API/REST/REST-Consumers.htm) on the [Solace PubSub+ Event Broker](https://solace.com/products/event-broker/).

Given a queue on the broker, as a destination for messages to be forwarded to a REST consumer application, this module configures a [REST delivery point](https://docs.solace.com/API/REST/REST-Consumers.htm#_Toc433874658) between the queue and the application.

Specific use case details are provided in the [Examples](#examples).

## Module input variables

### Required

* `msg_vpn_name` - REST delivery points are specific to a Message VPN on the broker.
* `rest_delivery_point_name` - The name of the REST delivery point to be created.
* `url` - The REST consumer destination URL including base URL and endpoint path. The path portion of the URL may contain [substitution expressions](https://docs.solace.com/Messaging/Substitution-Expressions-Overview.htm).
* `queue_name` - The name of the queue to bind to.

Important: The REST delivery point must have permission to consume messages from the queue — to achieve this, the queue’s owner must be set to `#rdp/<rest_delivery_point_name>` or the queue’s permissions for non-owner clients must be set to at least `consume` level access. Queue ingress and egress must also be enabled.


### Optional

* `request_headers` - A set of request headers to be added to the HTTP request
* `protected_request_headers` - A set of protected request headers with sensitive value to be added to the HTTP request
* `oauth_jwt_claims` - A set of additional claims to be added to the JWT sent to the OAuth token request endpoint
* `rest_consumer_name` - The name of the REST consumer to be created. The default is `consumer`.

Additional optional module variables names are the same as the underlying resource attributes. The recommended approach to determine variable name mappings is to look up the resource's documentation for matching attribute names:

| Resource name |
|---------------|
|[solacebroker_msg_vpn_rest_delivery_point](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point#optional)|
|[solacebroker_msg_vpn_rest_delivery_point_rest_consumer](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_rest_consumer#optional)|
|[solacebroker_msg_vpn_rest_delivery_point_queue_binding](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_queue_binding#optional)|
|[solacebroker_msg_vpn_rest_delivery_point_queue_binding_request_header](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_queue_binding_request_header#optional)|
|[solacebroker_msg_vpn_rest_delivery_point_queue_binding_protected_request_header](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_queue_binding_protected_request_header#optional)|
|[solacebroker_msg_vpn_rest_delivery_point_rest_consumer_oauth_jwt_claim](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_rest_delivery_point_rest_consumer_oauth_jwt_claim#optional)|

Most optional variables' default value is `null`, meaning that if not provided then the resource default value will be provisioned on the broker.

-> The module default for the `enabled` optional variable is `true`, which differ from the resource attribute default.

## Module outputs

[Module outputs](https://developer.hashicorp.com/terraform/language/values/outputs) provide reference to created resources. Any reference to a resource that has not been created will be set to `(null)`.

Note that the "rest consumer" and the "protected request headers" outputs are [sensitive](https://developer.hashicorp.com/terraform/language/values/outputs#sensitive-suppressing-values-in-cli-output).

## Providers

| Name | Version |
|------|---------|
| <a name="provider_solacebroker"></a> [solacebroker](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest) | ~> 0.9 |

## Resources

The following table shows the resources created. "X" denotes a resource always created, "O" is a resource that may be created optionally  

| Name | |
|------|------|
| solacebroker_msg_vpn_rest_delivery_point | X |
| solacebroker_msg_vpn_rest_delivery_point_rest_consumer | X |
| solacebroker_msg_vpn_rest_delivery_point_queue_binding | X |
| solacebroker_msg_vpn_rest_delivery_point_queue_binding_request_header | O |
| solacebroker_msg_vpn_rest_delivery_point_queue_binding_protected_request_header | O |
| solacebroker_msg_vpn_rest_delivery_point_rest_consumer_oauth_jwt_claim | O |

## Examples

Refer to the following configuration examples:

- [Basic](examples/basic)
- [Substitution Expressions](examples/using-substitution-expressions)
- [Adding headers](examples/adding-headers)
- [Adding JWT claims (workaround)](examples/adding-oauth-jwt-claims-workaround)
- [Multiple queue bindings](examples/multiple-queue-bindings)
- [Amazon AWS consumer](examples/aws)
- [Microsoft Azure consumer](examples/azure)
- [Google Cloud consumer](examples/gcp)

## Module use recommendations

This module is expected to be used primarily by application teams. It supports provisioning endpoints or templates required by a specific application. It may be forked and adjusted with private defaults.

## Resources

For more information about Solace technology in general please visit these resources:

- Solace [Technical Documentation](https://docs.solace.com/)
    - [Managing REST Delivery Points](https://docs.solace.com/Services/Managing-RDPs.htm)
- The Solace Developer Portal website at: [solace.dev](//solace.dev/)
- Understanding [Solace technology](//solace.com/products/platform/)
- Ask the [Solace community](//dev.solace.com/community/).
