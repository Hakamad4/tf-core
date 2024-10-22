variable "project_id" {
  description = "The project ID to host the cluster in (required)"
  type        = string
}

variable "name" {
  description = "The name of the cluster (required)"
  type        = string
}

variable "description" {
  description = "The description of the cluster"
  type        = string
  default     = ""
}

variable "regional" {
  description = "Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!)"
  type        = bool
  default     = true
}

variable "region" {
  description = "The region to host the cluster in (optional if zonal cluster / required if regional)"
  type        = string
  default     = null
}

variable "zones" {
  description = "The zones to host the cluster in (optional if regional cluster / required if zonal)"
  type        = list(string)
  default     = []
}

variable "network" {
  description = "The VPC network to host the cluster in (required)"
  type        = string
}

variable "network_project_id" {
  description = "The project ID of the shared VPC's host (for shared vpc support)"
  type        = string
  default     = ""
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in (required)"
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region."
  type        = string
  default     = "latest"
}

variable "master_authorized_networks" {
  description = "List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists)."
  type        = list(object({ cidr_block = string, display_name = string }))
  default     = []
}

variable "enable_vertical_pod_autoscaling" {
  description = "Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it"
  type        = bool
  default     = true
}

variable "horizontal_pod_autoscaling" {
  description = "Enable horizontal pod autoscaling addon"
  type        = bool
  default     = true
}

variable "http_load_balancing" {
  description = "Enable httpload balancer addon"
  type        = bool
  default     = true
}

variable "service_external_ips" {
  description = "Whether external ips specified by a service will be allowed in this cluster"
  type        = bool
  default     = false
}

variable "maintenance_start_time" {
  description = "Time window specified for daily or recurring maintenance operations in RFC3339 format"
  type        = string
  default     = "05:00"
}

variable "maintenance_exclusions" {
  description = "List of maintenance exclusions. A cluster can have up to three"
  type        = list(object({ name = string, start_time = string, end_time = string, exclusion_scope = string }))
  default     = []
}

variable "maintenance_end_time" {
  description = "Time window specified for recurring maintenance operations in RFC3339 format"
  type        = string
  default     = ""
}

variable "maintenance_recurrence" {
  description = "Frequency of the recurring maintenance window in RFC5545 format."
  type        = string
  default     = ""
}

variable "ip_range_pods" {
  description = "The _name_ of the secondary subnet ip range to use for pods"
  type        = string
}

variable "additional_ip_range_pods" {
  description = "List of _names_ of the additional secondary subnet ip ranges to use for pods"
  type        = list(string)
  default     = []
}

variable "ip_range_services" {
  description = "The _name_ of the secondary subnet range to use for services"
  type        = string
}


variable "enable_cost_allocation" {
  description = "Enables Cost Allocation Feature and the cluster name and namespace of your GKE workloads appear in the labels field of the billing export to BigQuery"
  type        = bool
  default     = false
}
variable "resource_usage_export_dataset_id" {
  description = "The ID of a BigQuery Dataset for using BigQuery as the destination of resource usage export."
  type        = string
  default     = ""
}

variable "enable_network_egress_export" {
  description = "Whether to enable network egress metering for this cluster. If enabled, a daemonset will be created in the cluster to meter network egress traffic."
  type        = bool
  default     = false
}

variable "enable_resource_consumption_export" {
  description = "Whether to enable resource consumption metering on this cluster. When enabled, a table will be created in the resource export BigQuery dataset to store resource consumption data. The resulting table can be joined with the resource usage table or with BigQuery billing export."
  type        = bool
  default     = true
}


variable "network_tags" {
  description = "(Optional, Beta) - List of network tags applied to auto-provisioned node pools."
  type        = list(string)
  default     = []
}
variable "stub_domains" {
  description = "Map of stub domains and their resolvers to forward DNS queries for a certain domain to an external DNS server"
  type        = map(list(string))
  default     = {}
}

variable "upstream_nameservers" {
  description = "If specified, the values replace the nameservers taken by default from the node’s /etc/resolv.conf"
  type        = list(string)
  default     = []
}

variable "non_masquerade_cidrs" {
  description = "List of strings in CIDR notation that specify the IP address ranges that do not use IP masquerading."
  type        = list(string)
  default     = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}

variable "ip_masq_resync_interval" {
  description = "The interval at which the agent attempts to sync its ConfigMap file from the disk."
  type        = string
  default     = "60s"
}

variable "ip_masq_link_local" {
  description = "Whether to masquerade traffic to the link-local prefix (169.254.0.0/16)."
  type        = bool
  default     = false
}

variable "configure_ip_masq" {
  description = "Enables the installation of ip masquerading, which is usually no longer required when using aliasied IP addresses. IP masquerading uses a kubectl call, so when you have a private cluster, you will need access to the API server."
  type        = bool
  default     = false
}

variable "create_service_account" {
  description = "Defines if service account specified to run nodes should be created."
  type        = bool
  default     = true
}

variable "grant_registry_access" {
  description = "Grants created cluster-specific service account storage.objectViewer and artifactregistry.reader roles."
  type        = bool
  default     = false
}

variable "registry_project_ids" {
  description = "Projects holding Google Container Registries. If empty, we use the cluster project. If a service account is created and the `grant_registry_access` variable is set to `true`, the `storage.objectViewer` and `artifactregsitry.reader` roles are assigned on these projects."
  type        = list(string)
  default     = []
}

variable "service_account" {
  description = "The service account to run nodes as if not overridden in `node_pools`. The create_service_account variable default value (true) will cause a cluster-specific service account to be created. This service account should already exists and it will be used by the node pools. If you wish to only override the service account name, you can use service_account_name variable."
  type        = string
  default     = ""
}

variable "service_account_name" {
  description = "The name of the service account that will be created if create_service_account is true. If you wish to use an existing service account, use service_account variable."
  type        = string
  default     = ""
}

variable "issue_client_certificate" {
  description = "Issues a client certificate to authenticate to the cluster endpoint. To maximize the security of your cluster, leave this option disabled. Client certificates don't automatically rotate and aren't easily revocable. WARNING: changing this after cluster creation is destructive!"
  type        = bool
  default     = false
}

variable "cluster_ipv4_cidr" {
  description = "The IP address range of the kubernetes pods in this cluster. Default is an automatically assigned CIDR."
  type        = string
  default     = null
}

variable "cluster_resource_labels" {
  description = "The GCE resource labels (a map of key/value pairs) to be applied to the cluster"
  type        = map(string)
  default     = {}
}


variable "deploy_using_private_endpoint" {
  description = "(Beta) A toggle for Terraform and kubectl to connect to the master's internal IP address during deployment."
  type        = bool
  default     = false
}

variable "enable_private_endpoint" {
  description = "(Beta) Whether the master's internal IP address is used as the cluster endpoint"
  type        = bool
  default     = false
}

variable "enable_private_nodes" {
  description = "(Beta) Whether nodes have internal IP addresses only"
  type        = bool
  default     = false
}

variable "master_ipv4_cidr_block" {
  description = "(Beta) The IP range in CIDR notation to use for the hosted master network"
  type        = string
  default     = "10.0.0.0/28"
}

variable "master_global_access_enabled" {
  description = "Whether the cluster master is accessible globally (from any region) or only within the same region as the private endpoint."
  type        = bool
  default     = true
}

variable "dns_cache" {
  description = "The status of the NodeLocal DNSCache addon."
  type        = bool
  default     = true
}

variable "authenticator_security_group" {
  description = "The name of the RBAC security group for use with Google security groups in Kubernetes RBAC. Group name must be in format gke-security-groups@yourdomain.com"
  type        = string
  default     = null
}

variable "identity_namespace" {
  description = "The workload pool to attach all Kubernetes service accounts to. (Default value of `enabled` automatically sets project-based pool `[project_id].svc.id.goog`)"
  type        = string
  default     = "enabled"
}


variable "release_channel" {
  description = "The release channel of this cluster. Accepted values are `UNSPECIFIED`, `RAPID`, `REGULAR` and `STABLE`. Defaults to `REGULAR`."
  type        = string
  default     = "REGULAR"
}

variable "gateway_api_channel" {
  description = "The gateway api channel of this cluster. Accepted values are `CHANNEL_STANDARD` and `CHANNEL_DISABLED`."
  type        = string
  default     = null
}

variable "add_cluster_firewall_rules" {
  description = "Create additional firewall rules"
  type        = bool
  default     = false
}

variable "add_master_webhook_firewall_rules" {
  description = "Create master_webhook firewall rules for ports defined in `firewall_inbound_ports`"
  type        = bool
  default     = false
}

variable "firewall_priority" {
  description = "Priority rule for firewall rules"
  type        = number
  default     = 1000
}

variable "firewall_inbound_ports" {
  description = "List of TCP ports for admission/webhook controllers. Either flag `add_master_webhook_firewall_rules` or `add_cluster_firewall_rules` (also adds egress rules) must be set to `true` for inbound-ports firewall rules to be applied."
  type        = list(string)
  default     = ["8443", "9443", "15017"]
}

variable "add_shadow_firewall_rules" {
  description = "Create GKE shadow firewall (the same as default firewall rules with firewall logs enabled)."
  type        = bool
  default     = false
}

variable "shadow_firewall_rules_priority" {
  description = "The firewall priority of GKE shadow firewall rules. The priority should be less than default firewall, which is 1000."
  type        = number
  default     = 999
  validation {
    condition     = var.shadow_firewall_rules_priority < 1000
    error_message = "The shadow firewall rule priority must be lower than auto-created one(1000)."
  }
}

variable "shadow_firewall_rules_log_config" {
  description = "The log_config for shadow firewall rules. You can set this variable to `null` to disable logging."
  type = object({
    metadata = string
  })
  default = {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

variable "enable_confidential_nodes" {
  description = "An optional flag to enable confidential node config."
  type        = bool
  default     = false
}

variable "workload_vulnerability_mode" {
  description = "(beta) Vulnerability mode."
  type        = string
  default     = ""
}

variable "workload_config_audit_mode" {
  description = "(beta) Workload config audit mode."
  type        = string
  default     = "DISABLED"
}

variable "enable_fqdn_network_policy" {
  description = "Enable FQDN Network Policies on the cluster"
  type        = bool
  default     = null
}

variable "disable_default_snat" {
  description = "Whether to disable the default SNAT to support the private use of public IP addresses"
  type        = bool
  default     = false
}

variable "notification_config_topic" {
  description = "The desired Pub/Sub topic to which notifications will be sent by GKE. Format is projects/{project}/topics/{topic}."
  type        = string
  default     = ""
}

variable "enable_tpu" {
  description = "Enable Cloud TPU resources in the cluster. WARNING: changing this after cluster creation is destructive!"
  type        = bool
  default     = false
}
variable "database_encryption" {
  description = "Application-layer Secrets Encryption settings. The object format is {state = string, key_name = string}. Valid values of state are: \"ENCRYPTED\"; \"DECRYPTED\". key_name is the name of a CloudKMS key."
  type        = list(object({ state = string, key_name = string }))
  default = [{
    state    = "DECRYPTED"
    key_name = ""
  }]
}


variable "timeouts" {
  description = "Timeout for cluster operations."
  type        = map(string)
  default     = {}
  validation {
    condition     = !contains([for t in keys(var.timeouts) : contains(["create", "update", "delete"], t)], false)
    error_message = "Only create, update, delete timeouts can be specified."
  }
}
