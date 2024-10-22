output "instance_name" {
  description = "The instance name for the master instance"
  value       = google_sql_database_instance.default.name
}

output "instance_ip_address" {
  description = "The IPv4 address assigned for the master instance"
  value       = google_sql_database_instance.default.ip_address
}

output "private_address" {
  description = "The private IP address assigned for the master instance"
  value       = google_sql_database_instance.default.private_ip_address
}

output "instance_first_ip_address" {
  description = "The first IPv4 address of the addresses assigned for the master instance."
  value       = google_sql_database_instance.default.first_ip_address
}

output "instance_connection_name" {
  description = "The connection name of the master instance to be used in connection strings"
  value       = google_sql_database_instance.default.connection_name
}

output "instance_self_link" {
  description = "The URI of the master instance"
  value       = google_sql_database_instance.default.self_link
}

output "instance_server_ca_cert" {
  description = "The CA certificate information used to connect to the SQL instance via SSL"
  value       = google_sql_database_instance.default.server_ca_cert
}

output "instance_service_account_email_address" {
  description = "The service account email address assigned to the master instance"
  value       = google_sql_database_instance.default.service_account_email_address
}

output "instance_psc_attachment" {
  description = "The psc_service_attachment_link created for the master instance"
  value       = google_sql_database_instance.default.psc_service_attachment_link
}

output "replicas_instance_first_ip_addresses" {
  description = "The first IPv4 addresses of the addresses assigned for the replica instances"
  value       = [for r in google_sql_database_instance.replicas : r.ip_address]
}

output "replicas_instance_connection_names" {
  description = "The connection names of the replica instances to be used in connection strings"
  value       = [for r in google_sql_database_instance.replicas : r.connection_name]
}

output "replicas_instance_self_links" {
  description = "The URIs of the replica instances"
  value       = [for r in google_sql_database_instance.replicas : r.self_link]
}

output "replicas_instance_server_ca_certs" {
  description = "The CA certificates information used to connect to the replica instances via SSL"
  value       = [for r in google_sql_database_instance.replicas : r.server_ca_cert]
}

output "replicas_instance_service_account_email_addresses" {
  description = "The service account email addresses assigned to the replica instances"
  value       = [for r in google_sql_database_instance.replicas : r.service_account_email_address]
}

output "read_replica_instance_names" {
  description = "The instance names for the read replica instances"
  value       = [for r in google_sql_database_instance.replicas : r.name]
}

output "generated_user_password" {
  description = "The auto generated default user password if not input password was provided"
  value       = random_password.user-password.result
  sensitive   = true
}

output "additional_users" {
  description = "List of maps of additional users and passwords"
  value = [for r in google_sql_user.additional_users :
    {
      name     = r.name
      password = r.password
      type     = r.type
      host     = r.host
    }
  ]
  sensitive = true
}

output "public_ip_address" {
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance"
  value       = google_sql_database_instance.default.public_ip_address
}

output "private_ip_address" {
  description = "The first private (PRIVATE) IPv4 address assigned for the master instance"
  value       = google_sql_database_instance.default.private_ip_address
}

output "iam_users" {
  description = "The list of the IAM users with access to the CloudSQL instance"
  value       = var.iam_users
}

output "primary" {
  description = "The `google_sql_database_instance` resource representing the primary instance"
  value       = google_sql_database_instance.default
  sensitive   = true
}

output "replicas" {
  description = "A list of `google_sql_database_instance` resources representing the replicas"
  value       = values(google_sql_database_instance.replicas)
  sensitive   = true
}

output "instances" {
  description = "A list of all `google_sql_database_instance` resources we've created"
  value       = concat([google_sql_database_instance.default], values(google_sql_database_instance.replicas))
  sensitive   = true
}
