output "external_ip_address_kuber-control-plane" {
  value = yandex_compute_instance.kuber-control-plane.network_interface.0.nat_ip_address
}

output "external_ip_address_kuber-node" {
  value = yandex_compute_instance.kuber-node.network_interface.0.nat_ip_address
}
