module "vcn" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-vcn.git"

  compartment_ocid = var.compartment_ocid
  name             = "fk-private-dns-vcn"
  vcn_cidr_blocks  = ["10.40.0.0/16"]

  create_nat_gateway     = true
  create_service_gateway = true

  route_tables = {
    private = {
      route_rules = [
        {
          destination        = "0.0.0.0/0"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "nat_gateway"
        },
        {
          destination        = "all-services"
          destination_type   = "SERVICE_CIDR_BLOCK"
          network_entity_key = "service_gateway"
        }
      ]
    }
  }

  security_lists = {
    app = {
      ingress_rules = [
        {
          description = "Allow VCN-internal SSH"
          protocol    = "6"
          source      = "10.40.0.0/16"
          tcp_options = {
            min = 22
            max = 22
          }
        }
      ]
      egress_rules = [
        {
          description = "Allow all outbound"
          protocol    = "all"
          destination = "0.0.0.0/0"
        }
      ]
    }
  }

  subnets = {
    app = {
      display_name                  = "fk-private-dns-app"
      cidr_block                    = "10.40.1.0/24"
      route_table_key               = "private"
      security_list_keys            = ["app"]
      include_default_security_list = false
      prohibit_internet_ingress     = true
      prohibit_public_ip_on_vnic    = true
    }
  }
}

module "private_dns" {
  source = "../.."

  compartment_ocid = var.compartment_ocid
  name             = "fk-private-dns"
  vcn_id           = module.vcn.vcn_id

  views = {
    app = {}
  }

  zones = {
    internal = {
      name     = "fk.internal"
      view_key = "app"
      rrsets = {
        app_a = {
          domain = "app.fk.internal"
          rtype  = "A"
          ttl    = 30
          items = [
            {
              rdata = "10.40.1.10"
            }
          ]
        }
      }
    }
  }
}
