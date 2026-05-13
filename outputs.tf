output "resolver_id" {
  description = "Managed or discovered resolver OCID."
  value       = local.effective_resolver_id
}

output "view_ids" {
  description = "Map of private view keys to OCIDs."
  value = {
    for key, view in oci_dns_view.this : key => view.id
  }
}

output "zone_ids" {
  description = "Map of private zone keys to OCIDs."
  value = {
    for key, zone in oci_dns_zone.this : key => zone.id
  }
}

output "zone_names" {
  description = "Map of private zone keys to DNS names."
  value = {
    for key, zone in oci_dns_zone.this : key => zone.name
  }
}

output "rrset_ids" {
  description = "Map of RRSet keys to resource IDs."
  value = {
    for key, rrset in oci_dns_rrset.this : key => rrset.id
  }
}
