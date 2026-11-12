# Synthetic fixtures only. Every run is plan-only; no tenancy credentials are used.
mock_provider "oci" {
  mock_data "oci_core_vcn_dns_resolver_association" {
    defaults = { "dns_resolver_id" = "MOCK_OCID_MOCK", "id" = "MOCK_OCID_ASSOCIATION", "state" = "AVAILABLE" }
  }
  mock_resource "oci_dns_resolver" {
    defaults = { "attached_vcn_id" = "MOCK_OCID_MOCK", "default_view_id" = "MOCK_OCID_MOCK", "endpoints" = [{ "compartment_id" = "MOCK_OCID_COMPARTMENT", "defined_tags" = {}, "endpoint_type" = "mock-value", "forwarding_address" = "mock-value", "freeform_tags" = {}, "id" = "MOCK_OCID_MOCK", "is_forwarding" = false, "is_listening" = false, "listening_address" = "mock-value", "name" = "compatibility", "pe_id" = "MOCK_OCID_MOCK", "resolver_id" = "MOCK_OCID_MOCK", "security_attributes" = {}, "self" = "mock-value", "state" = "AVAILABLE", "subnet_id" = "MOCK_OCID_SUBNET", "time_created" = "mock-value", "time_updated" = "mock-value", "vnic_id" = "MOCK_OCID_MOCK" }], "id" = "MOCK_OCID_RESOLVER", "is_protected" = false, "self" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value", "time_updated" = "mock-value" }
  }
  mock_resource "oci_dns_rrset" {
    defaults = { "id" = "MOCK_OCID_RRSET" }
  }
  mock_resource "oci_dns_view" {
    defaults = { "id" = "MOCK_OCID_VIEW", "is_protected" = false, "self" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value", "time_updated" = "mock-value" }
  }
  mock_resource "oci_dns_zone" {
    defaults = { "dnssec_config" = [{ "ksk_dnssec_key_versions" = [{ "algorithm" = "mock-value", "ds_data" = [], "key_tag" = 1, "length_in_bytes" = 1, "predecessor_dnssec_key_version_uuid" = "mock-value", "successor_dnssec_key_version_uuid" = "mock-value", "time_activated" = "mock-value", "time_created" = "mock-value", "time_expired" = "mock-value", "time_inactivated" = "mock-value", "time_promoted" = "mock-value", "time_published" = "mock-value", "time_unpublished" = "mock-value", "uuid" = "mock-value" }], "zsk_dnssec_key_versions" = [{ "algorithm" = "mock-value", "key_tag" = 1, "length_in_bytes" = 1, "predecessor_dnssec_key_version_uuid" = "mock-value", "successor_dnssec_key_version_uuid" = "mock-value", "time_activated" = "mock-value", "time_created" = "mock-value", "time_expired" = "mock-value", "time_inactivated" = "mock-value", "time_promoted" = "mock-value", "time_published" = "mock-value", "time_unpublished" = "mock-value", "uuid" = "mock-value" }] }], "id" = "MOCK_OCID_ZONE", "is_protected" = false, "nameservers" = [{ "hostname" = "mock-value" }], "self" = "mock-value", "serial" = 1, "state" = "AVAILABLE", "time_created" = "mock-value", "version" = "mock-value", "zone_transfer_servers" = [{ "address" = "mock-value", "is_transfer_destination" = false, "is_transfer_source" = false, "port" = 1 }] }
  }
}
variables {
  compartment_ocid = "MOCK_OCID_COMPARTMENT"
  name             = "compatibility"
  vcn_id           = "MOCK_OCID_MOCK"
}

run "oci9_plan" {
  command = plan
}
