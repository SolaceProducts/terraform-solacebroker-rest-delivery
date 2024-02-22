# Output variable definitions

output "rest_delivery_point" {
  value       = solacebroker_msg_vpn_rest_delivery_point.main
}

output "rest_consumer" {
  value       = solacebroker_msg_vpn_rest_delivery_point_rest_consumer.main
}

output "queue_binding" {
  value       = solacebroker_msg_vpn_rest_delivery_point_queue_binding.main
}
