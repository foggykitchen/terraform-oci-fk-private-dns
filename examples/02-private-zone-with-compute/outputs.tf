output "vcn_id" {
  description = "VCN OCID."
  value       = module.vcn.vcn_id
}

output "resolver_id" {
  description = "Private resolver OCID."
  value       = module.private_dns.resolver_id
}

output "view_ids" {
  description = "Private view IDs."
  value       = module.private_dns.view_ids
}

output "zone_ids" {
  description = "Private zone IDs."
  value       = module.private_dns.zone_ids
}

output "instance_id" {
  description = "Compute instance OCID."
  value       = module.compute.instance_id
}

output "instance_private_ip" {
  description = "Private IP of the compute instance."
  value       = module.compute.instance_private_ip
}

output "instance_public_ip" {
  description = "Public IP of the compute instance."
  value       = module.compute.instance_public_ip
}
