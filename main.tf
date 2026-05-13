locals {
  managed_view_ids = {
    for key, view in oci_dns_view.this : key => view.id
  }

  discovered_resolver_id = try(data.oci_core_vcn_dns_resolver_association.this[0].dns_resolver_id, null)
  effective_resolver_id  = coalesce(var.resolver_id, local.discovered_resolver_id)

  effective_attached_view_ids = concat(
    [for key in keys(var.views) : local.managed_view_ids[key]],
    var.extra_attached_view_ids
  )

  rrsets = length(var.zones) == 0 ? {} : merge([
    for zone_key, zone in var.zones : {
      for rrset_key, rrset in try(zone.rrsets, {}) : "${zone_key}-${rrset_key}" => {
        zone_key = zone_key
        domain   = rrset.domain
        rtype    = rrset.rtype
        ttl      = rrset.ttl
        items    = rrset.items
      }
    }
  ]...)
}

data "oci_core_vcn_dns_resolver_association" "this" {
  count = var.resolver_id == null && var.attach_managed_views_to_resolver ? 1 : 0

  vcn_id = var.vcn_id
}

resource "oci_dns_view" "this" {
  for_each = var.views

  compartment_id = var.compartment_ocid
  scope          = "PRIVATE"
  display_name   = coalesce(try(each.value.display_name, null), "${var.name}-${each.key}")

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

resource "oci_dns_zone" "this" {
  for_each = var.zones

  compartment_id = var.compartment_ocid
  name           = each.value.name
  zone_type      = "PRIMARY"
  scope          = "PRIVATE"
  view_id        = try(each.value.view_id, null) != null ? each.value.view_id : oci_dns_view.this[each.value.view_key].id

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}

resource "oci_dns_rrset" "this" {
  for_each = local.rrsets

  zone_name_or_id = oci_dns_zone.this[each.value.zone_key].id
  domain          = each.value.domain
  rtype           = each.value.rtype

  dynamic "items" {
    for_each = each.value.items
    content {
      domain = each.value.domain
      rdata  = items.value.rdata
      rtype  = each.value.rtype
      ttl    = coalesce(try(items.value.ttl, null), each.value.ttl)
    }
  }
}

resource "oci_dns_resolver" "this" {
  count = var.attach_managed_views_to_resolver && local.effective_resolver_id != null && length(local.effective_attached_view_ids) > 0 ? 1 : 0

  resolver_id = local.effective_resolver_id
  scope       = "PRIVATE"

  dynamic "attached_views" {
    for_each = local.effective_attached_view_ids
    content {
      view_id = attached_views.value
    }
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}
