# Adding OAuth JWT Claims REST Delivery Configuration Example

This example shows how to add optional additional OAuth JWT claims that the REST consumer will use to request access tokens when configuring [REST messaging](https://docs.solace.com/API/REST/REST-Consumers.htm) on the PubSub+ event broker, leveraging the REST Delivery Terraform module.

## Issue and workaround

The `enabled` module input variable controls if the `rest_delivery_point` and the `rest_delivery_point_rest_consumer` resources are administratively enabled.
The module default is `true`. While this default ensures that the broker is ready for outgoing REST messaging after configuration, it conflicts with a current capability of the Solace provider: optional additional OAuth JWT claims can only be configured on administratively disabled REST consumer resources.

To work around this until the provider capability is added, if using the `oauth_jwt_claims` module input variable, apply the module in two passes: first with `enabled` set to `false`, then with `enabled` set to true. To conveniently do this, define an input variable with default set to `true` for the root configuration, pass its value to the module `enabled` input, and then control the variable from the Terraform CLI:

```bash
terraform apply -var="enabled=false"  # applies the config with adminstratively disabled RDP and REST consumer
terraform apply                       # only changes the admin status of the RDP and the REST consumer (enabled default is true)
```

When modifying or deleting the config, first apply the current config to adminstratively disable the RDP and the REST consumer:
```bash
terraform apply -var="enabled=false"  # only changes the admin status of the RDP and the REST consumer (assuming the config has not changed)
terraform destroy                     # this one deletes the config. To modify the config, use above two-pass apply
```

To clarify, this workaround is only required when changing the `oauth_jwt_claims` module input variable.

## Module Configuration in the Example

Note: the focus of this example is adding optional additional OAuth JWT claims. While there are some 

### Required Inputs

* `msg_vpn_name` - set to `default` in the example
* `rest_delivery_point_name`
* `url` - set to `https://example.com/test` in the example. Note that it includes the endpoint path
* `queue_name` - `rdp_queue`, the queue that has been created to be used with the RDP

Important: The REST delivery point must have permission to consume messages from the queue — to achieve this, the queue’s owner must be set to `#rdp/<rest_delivery_point_name>` or the queue’s permissions for non-owner clients must be set to at least `consume` level access. Queue ingress and egress must also be enabled.

### Optional Inputs

* `oauth_jwt_claims` - the set of additional claims, `scope` and `iss` in the example

Optional module input variables have the same name as the attributes of the underlying provider resource. If omitted then the default for the related resource attribute will be configured on the broker. For attributes and defaults, refer to the [documentation of "solacebroker_msg_vpn_queue"](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs/resources/msg_vpn_queue#optional).

The module default for the `enabled` variable is true, which enables both the RDP and the REST consumer resources.

### Output

The module `rdp` output refers to the created REST delivery point.

## Created resources

This example will create following resources:

* `solacebroker_msg_vpn_queue` (created before the module, as pre-requisite)
</br></br>
* `solacebroker_msg_vpn_rest_delivery_point`
* `solacebroker_msg_vpn_rest_delivery_point_rest_consumer`
* `solacebroker_msg_vpn_rest_delivery_point_queue_binding`
* `solacebroker_msg_vpn_rest_delivery_point_rest_consumer_oauth_jwt_claim`

## Running the Example

### Access to a PubSub+ broker

If you don't already have access to a broker, refer to the [Developers page](https://www.solace.dev/) for options to get started.

### Sample source code

The sample is available from the module GitHub repo:

```bash
git clone https://github.com/SolaceProducts/terraform-solacebroker-rest-delivery.git
cd examples/adding-oauth-jwt-claims-workaround
```

### Adjust Provider Configuration

Adjust the [provider parameters](https://registry.terraform.io/providers/SolaceProducts/solacebroker/latest/docs#schema) in `main.tf` according to your broker. The example configuration shows settings for a local broker running in Docker.

### Create the resource

Hint: You can verify configuration changes on the broker, before and after, using the [PubSub+ Broker Manager Web UI](https://docs.solace.com/Admin/Broker-Manager/PubSub-Manager-Overview.htm)

Execute from this folder:

```bash
terraform init
terraform plan
terraform apply -var="enabled=false"
terraform apply
```

Run `terraform destroy` to clean up created resources when no longer needed.

## Additional Documentation

Refer to the [Managing REST Delivery Points](https://docs.solace.com/Services/Managing-RDPs.htm) section in the PubSub+ documentation.
