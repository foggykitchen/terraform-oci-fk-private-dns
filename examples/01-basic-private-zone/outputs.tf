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
