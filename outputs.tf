# Output variable definitions

output "rest_delivery_point" {
  value       = solacebroker_msg_vpn_rest_delivery_point.main
  description = "A REST Delivery Point manages delivery of messages from queues to a named list of REST Consumers."
}

output "rest_consumer" {
  value       = solacebroker_msg_vpn_rest_delivery_point_rest_consumer.main
  description = "REST Consumer objects establish HTTP connectivity to REST consumer applications who wish to receive messages from a broker."
}

output "queue_binding" {
  value       = solacebroker_msg_vpn_rest_delivery_point_queue_binding.main
  description = "A Queue Binding for a REST Delivery Point attracts messages to be delivered to REST consumers. If the queue does not exist it can be created subsequently, and once the queue is operational the broker performs the queue binding. Removing the queue binding does not delete the queue itself. Similarly, removing the queue does not remove the queue binding, which fails until the queue is recreated or the queue binding is deleted."
}

