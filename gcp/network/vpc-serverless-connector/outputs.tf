output "connector_ids" {
  description = "VPC serverless connector ID."
  value = toset([
  for k in google_vpc_access_connector.connector : k.id])
}
