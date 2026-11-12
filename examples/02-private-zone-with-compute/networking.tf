module "vcn" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-vcn.git?ref=v0.2.1"

  compartment_ocid = var.compartment_ocid
  name             = "fk-private-dns-compute-vcn"
  vcn_cidr_blocks  = ["10.40.0.0/16"]

  create_internet_gateway = true

  route_tables = {
    public = {
      route_rules = [
        {
          destination        = "0.0.0.0/0"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "internet_gateway"
        }
      ]
    }
  }

  security_lists = {
    public_compute = {
      ingress_rules = [
        {
          description = "Allow SSH from the Internet"
          protocol    = "6"
          source      = "0.0.0.0/0"
          tcp_options = {
            min = 22
            max = 22
          }
        },
        {
          description = "Allow HTTP from the Internet"
          protocol    = "6"
          source      = "0.0.0.0/0"
          tcp_options = {
            min = 80
            max = 80
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
    public = {
      display_name               = "fk-private-dns-compute-public"
      cidr_block                 = "10.40.10.0/24"
      route_table_key            = "public"
      security_list_keys         = ["public_compute"]
      prohibit_public_ip_on_vnic = false
    }
  }
}

module "private_dns" {
  source = "../.."

  compartment_ocid = var.compartment_ocid
  name             = "fk-private-dns-compute"
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
              rdata = "10.40.10.10"
            }
          ]
        }
      }
    }
  }
}
