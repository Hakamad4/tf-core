resource "google_compute_firewall" "intra_egress" {
  count       = var.add_cluster_firewall_rules ? 1 : 0
  name        = "gke-${substr(var.name, 0, min(36, length(var.name)))}-intra-cluster-egress"
  description = "Managed by terraform gke module: Allow pods to communicate with each other and the master"
  project     = local.network_project_id
  network     = var.network
  priority    = var.firewall_priority
  direction   = "EGRESS"

  target_tags = [local.cluster_network_tag]
  destination_ranges = concat([
    local.cluster_endpoint_for_nodes,
    local.cluster_subnet_cidr,
    ],
    local.pod_all_ip_ranges
  )

  allow { protocol = "tcp" }
  allow { protocol = "udp" }
  allow { protocol = "icmp" }
  allow { protocol = "sctp" }
  allow { protocol = "esp" }
  allow { protocol = "ah" }

}

resource "google_compute_firewall" "lb_health_check" {
  name        = "gke-${substr(var.name, 0, min(36, length(var.name)))}-fw-ingress-all"
  description = "Managed by terraform gke module: Permits ingress traffic to reach a Service."
  project     = local.network_project_id
  network     = var.network
  priority    = var.firewall_priority
  direction   = "INGRESS"

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "209.85.152.0/22", "209.85.204.0/22"]
  source_tags   = []
  target_tags   = []

  allow { protocol = "tcp" }
  allow { protocol = "udp" }

}

resource "google_compute_firewall" "tpu_egress" {
  count       = var.add_cluster_firewall_rules && var.enable_tpu ? 1 : 0
  name        = "gke-${substr(var.name, 0, min(36, length(var.name)))}-tpu-egress"
  description = "Managed by terraform gke module: Allow pods to communicate with TPUs"
  project     = local.network_project_id
  network     = var.network
  priority    = var.firewall_priority
  direction   = "EGRESS"

  target_tags        = [local.cluster_network_tag]
  destination_ranges = [google_container_cluster.primary.tpu_ipv4_cidr_block]

  allow { protocol = "tcp" }
  allow { protocol = "udp" }
  allow { protocol = "icmp" }
  allow { protocol = "sctp" }
  allow { protocol = "esp" }
  allow { protocol = "ah" }

}

resource "google_compute_firewall" "master_webhooks" {
  count       = var.add_cluster_firewall_rules || var.add_master_webhook_firewall_rules ? 1 : 0
  name        = "gke-${substr(var.name, 0, min(36, length(var.name)))}-webhooks"
  description = "Managed by terraform gke module: Allow master to hit pods for admission controllers/webhooks"
  project     = local.network_project_id
  network     = var.network
  priority    = var.firewall_priority
  direction   = "INGRESS"

  source_ranges = [local.cluster_endpoint_for_nodes]
  source_tags   = []
  target_tags   = [local.cluster_network_tag]

  allow {
    protocol = "tcp"
    ports    = var.firewall_inbound_ports
  }
}

resource "google_compute_firewall" "shadow_allow_pods" {
  count = var.add_shadow_firewall_rules ? 1 : 0

  name        = "gke-shadow-${substr(var.name, 0, min(36, length(var.name)))}-all"
  description = "Managed by terraform gke module: A shadow firewall rule to match the default rule allowing pod communication."
  project     = local.network_project_id
  network     = var.network
  priority    = var.shadow_firewall_rules_priority
  direction   = "INGRESS"

  source_ranges = local.pod_all_ip_ranges
  target_tags   = [local.cluster_network_tag]

  # Allow all possible protocols
  allow { protocol = "tcp" }
  allow { protocol = "udp" }
  allow { protocol = "icmp" }
  allow { protocol = "sctp" }
  allow { protocol = "esp" }
  allow { protocol = "ah" }

  dynamic "log_config" {
    for_each = var.shadow_firewall_rules_log_config == null ? [] : [var.shadow_firewall_rules_log_config]
    content {
      metadata = log_config.value.metadata
    }
  }
}

resource "google_compute_firewall" "shadow_allow_master" {
  count = var.add_shadow_firewall_rules ? 1 : 0

  name        = "gke-shadow-${substr(var.name, 0, min(36, length(var.name)))}-master"
  description = "Managed by terraform GKE module: A shadow firewall rule to match the default rule allowing worker nodes communication."
  project     = local.network_project_id
  network     = var.network
  priority    = var.shadow_firewall_rules_priority
  direction   = "INGRESS"

  source_ranges = [local.cluster_endpoint_for_nodes]
  target_tags   = [local.cluster_network_tag]

  allow {
    protocol = "tcp"
    ports    = ["10250", "443"]
  }

  dynamic "log_config" {
    for_each = var.shadow_firewall_rules_log_config == null ? [] : [var.shadow_firewall_rules_log_config]
    content {
      metadata = log_config.value.metadata
    }
  }
}

resource "google_compute_firewall" "shadow_allow_nodes" {
  count = var.add_shadow_firewall_rules ? 1 : 0

  name        = "gke-shadow-${substr(var.name, 0, min(36, length(var.name)))}-vms"
  description = "Managed by Terraform GKE module: A shadow firewall rule to match the default rule allowing worker nodes communication."
  project     = local.network_project_id
  network     = var.network
  priority    = var.shadow_firewall_rules_priority
  direction   = "INGRESS"

  source_ranges = [local.cluster_subnet_cidr]
  target_tags   = [local.cluster_network_tag]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }

  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }

  dynamic "log_config" {
    for_each = var.shadow_firewall_rules_log_config == null ? [] : [var.shadow_firewall_rules_log_config]
    content {
      metadata = log_config.value.metadata
    }
  }
}

resource "google_compute_firewall" "shadow_allow_inkubelet" {
  count = var.add_shadow_firewall_rules ? 1 : 0

  name        = "gke-shadow-${substr(var.name, 0, min(36, length(var.name)))}-inkubelet"
  description = "Managed by terraform GKE module: A shadow firewall rule to match the default rule allowing worker nodes & pods communication to kubelet."
  project     = local.network_project_id
  network     = var.network
  priority    = var.shadow_firewall_rules_priority - 1
  direction   = "INGRESS"

  source_ranges = local.pod_all_ip_ranges
  source_tags   = [local.cluster_network_tag]
  target_tags   = [local.cluster_network_tag]

  allow {
    protocol = "tcp"
    ports    = ["10255"]
  }

  dynamic "log_config" {
    for_each = var.shadow_firewall_rules_log_config == null ? [] : [var.shadow_firewall_rules_log_config]
    content {
      metadata = log_config.value.metadata
    }
  }
}

resource "google_compute_firewall" "shadow_deny_exkubelet" {
  count = var.add_shadow_firewall_rules ? 1 : 0

  name        = "gke-shadow-${substr(var.name, 0, min(36, length(var.name)))}-exkubelet"
  description = "Managed by terraform GKE module: A shadow firewall rule to match the default deny rule to kubelet."
  project     = local.network_project_id
  network     = var.network
  priority    = var.shadow_firewall_rules_priority # rule created by GKE robot have prio 1000
  direction   = "INGRESS"

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [local.cluster_network_tag]

  deny {
    protocol = "tcp"
    ports    = ["10255"]
  }

  dynamic "log_config" {
    for_each = var.shadow_firewall_rules_log_config == null ? [] : [var.shadow_firewall_rules_log_config]
    content {
      metadata = log_config.value.metadata
    }
  }
}