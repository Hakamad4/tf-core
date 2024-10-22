resource "google_compute_router_nat" "nats" {
  for_each = {
    for n in var.nats :
    n.name => n
  }

  name                               = each.value.name
  project                            = google_compute_router.router.project
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = lookup(each.value, "nat_ip_allocate_option", length(lookup(each.value, "nat_ips", [])) > 0 ? "MANUAL_ONLY" : "AUTO_ONLY")
  source_subnetwork_ip_ranges_to_nat = lookup(each.value, "source_subnetwork_ip_ranges_to_nat", "ALL_SUBNETWORKS_ALL_IP_RANGES")
  //source_subnetwork_ip_ranges_to_nat = lookup(each.value, "source_subnetwork_ip_ranges_to_nat", lookup(each.value, "subnetworks", "") == "" ? "ALL_SUBNETWORKS_ALL_IP_RANGES" : "LIST_OF_SUBNETWORKS")
  nat_ips                             = lookup(each.value, "nat_ips", null)
  min_ports_per_vm                    = lookup(each.value, "min_ports_per_vm", null)
  max_ports_per_vm                    = lookup(each.value, "max_ports_per_vm", null)
  udp_idle_timeout_sec                = lookup(each.value, "udp_idle_timeout_sec", null)
  icmp_idle_timeout_sec               = lookup(each.value, "icmp_idle_timeout_sec", null)
  tcp_established_idle_timeout_sec    = lookup(each.value, "tcp_established_idle_timeout_sec", null)
  tcp_transitory_idle_timeout_sec     = lookup(each.value, "tcp_transitory_idle_timeout_sec", null)
  tcp_time_wait_timeout_sec           = lookup(each.value, "tcp_time_wait_timeout_sec", null)
  enable_endpoint_independent_mapping = lookup(each.value, "enable_endpoint_independent_mapping", null)
  enable_dynamic_port_allocation      = lookup(each.value, "enable_dynamic_port_allocation", null)

  log_config {
    enable = true
    filter = lookup(lookup(each.value, "log_config", {}), "filter", "ALL")
  }

  dynamic "subnetwork" {
    for_each = lookup(each.value, "subnetworks", [])
    content {
      name                     = subnetwork.value.name
      source_ip_ranges_to_nat  = subnetwork.value.source_ip_ranges_to_nat
      secondary_ip_range_names = lookup(subnetwork.value, "secondary_ip_range_names", null)
    }
  }
}
