# Synthetic fixtures only. Every run is plan-only; no tenancy credentials are used.
mock_provider "oci" {
  mock_data "oci_core_services" {
    defaults = { "id" = "MOCK_OCID_SERVICES", "services" = [{ "cidr_block" = "all-fra-services-in-oracle-services-network", "description" = "mock-value", "id" = "mock-service", "name" = "All FRA Services In Oracle Services Network" }] }
  }
  mock_data "oci_core_vcn_dns_resolver_association" {
    defaults = { "dns_resolver_id" = "MOCK_OCID_MOCK", "id" = "MOCK_OCID_ASSOCIATION", "state" = "AVAILABLE" }
  }
  mock_resource "oci_core_dhcp_options" {
    defaults = { "id" = "MOCK_OCID_OPTIONS", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_internet_gateway" {
    defaults = { "id" = "MOCK_OCID_GATEWAY", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_nat_gateway" {
    defaults = { "id" = "MOCK_OCID_GATEWAY", "nat_ip" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_route_table" {
    defaults = { "id" = "MOCK_OCID_TABLE", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_security_list" {
    defaults = { "id" = "MOCK_OCID_LIST", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_service_gateway" {
    defaults = { "block_traffic" = false, "id" = "MOCK_OCID_GATEWAY", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_subnet" {
    defaults = { "id" = "MOCK_OCID_SUBNET", "ipv6virtual_router_ip" = "mock-value", "state" = "AVAILABLE", "subnet_domain_name" = "mock-value", "time_created" = "mock-value", "virtual_router_ip" = "mock-value", "virtual_router_mac" = "mock-value" }
  }
  mock_resource "oci_core_vcn" {
    defaults = { "byoipv6cidr_blocks" = ["mock-value"], "default_dhcp_options_id" = "MOCK_OCID_MOCK", "default_route_table_id" = "MOCK_OCID_MOCK", "default_security_list_id" = "MOCK_OCID_MOCK", "id" = "MOCK_OCID_VCN", "ipv6cidr_blocks" = ["mock-value"], "state" = "AVAILABLE", "time_created" = "mock-value", "vcn_domain_name" = "mock-value" }
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
  tenancy_ocid     = "MOCK_OCID_TENANCY"
  user_ocid        = "MOCK_OCID_MOCK"
  fingerprint      = "compatibility"
  private_key_path = "/unused-by-mock"
  region           = "eu-frankfurt-1"
  compartment_ocid = "MOCK_OCID_COMPARTMENT"
}

run "oci9_plan" {
  command = plan
}
