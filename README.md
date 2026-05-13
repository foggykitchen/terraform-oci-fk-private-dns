# terraform-oci-fk-private-dns

This repository contains a reusable **Terraform/OpenTofu module** and progressive examples for deploying **Oracle Cloud Infrastructure (OCI) Private DNS** resources such as **views**, **private zones**, and **RRsets**, composed cleanly with reusable VCN foundations.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and serves as the OCI private name-resolution building block for platform networking, private services, and multicloud training scenarios.

---

## 🎯 Purpose

The goal of this module is to provide a **clean, composable, and educational reference implementation** for OCI private DNS:

- Focused on **private DNS views, zones, RRsets, and resolver view attachment**
- Designed to be compatible with **terraform-oci-fk-vcn** through `vcn_id`
- Based on the practical patterns from **terraform-oci-private-dns**, but refactored into a clean reusable module

This is **not** a full environment demo. It is a **small private-DNS foundation module** intended for learning, reuse, and composition.

---

## ✨ What the module does

The module creates:

- Optional private DNS views
- Optional private DNS zones
- Optional RRsets inside managed zones
- Optional attachment of managed views to the VCN-associated private resolver

The module intentionally does **not** create:
- VCNs
- Subnets
- Compute instances
- Load Balancers
- DRGs
- Resolver endpoints

Each of those concerns belongs in its own dedicated module or composition layer.

---

## 📂 Repository Structure

```bash
terraform-oci-fk-private-dns/
├── examples/
│   ├── 01-basic-private-zone/
│   └── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

All examples are runnable and demonstrate how private DNS composes with reusable OCI networking modules.

---

## 🚀 Example Usage

```hcl
module "private_dns" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-private-dns.git?ref=v0.1.0"

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
              rdata = "10.20.20.10"
            }
          ]
        }
      }
    }
  }
}
```

---

## ⚙️ Module Inputs

### Core inputs

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `compartment_ocid` | `string` | ✅ | Compartment OCID where private DNS resources will be created |
| `name` | `string` | ✅ | Base name used for private DNS resources |
| `vcn_id` | `string` | ✅ | VCN OCID used to discover the private resolver |
| `resolver_id` | `string` | ❌ | Optional private resolver OCID override |
| `attach_managed_views_to_resolver` | `bool` | ❌ | Whether to attach managed views to the resolver |
| `extra_attached_view_ids` | `list(string)` | ❌ | Additional private view IDs to preserve while managing resolver attachments |
| `defined_tags` | `map(string)` | ❌ | Defined tags |
| `freeform_tags` | `map(string)` | ❌ | Freeform tags |

### Private DNS objects

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `views` | `map(object)` | ❌ | Private DNS views to create |
| `zones` | `map(object)` | ❌ | Private DNS zones and RRsets to create |

### View object schema

```hcl
views = map(object({
  display_name = optional(string)
}))
```

### Zone object schema

```hcl
zones = map(object({
  name     = string
  view_key = optional(string)
  view_id  = optional(string)
  rrsets = optional(map(object({
    domain = string
    rtype  = string
    ttl    = number
    items = list(object({
      rdata = string
      ttl   = optional(number)
    }))
  })), {})
}))
```

Each zone must define either:
- `view_key` to attach the zone to a view created by this module
- `view_id` to attach the zone to an already existing private view

---

## 📤 Outputs

| Output | Description |
|------|-------------|
| `resolver_id` | Managed or discovered resolver OCID |
| `view_ids` | Map of private view keys to OCIDs |
| `zone_ids` | Map of private zone keys to OCIDs |
| `zone_names` | Map of private zone keys to DNS names |
| `rrset_ids` | Map of RRSet keys to resource IDs |

---

## 🧩 Examples Overview

| Example | Description |
|-------|-------------|
| `01-basic-private-zone` | One reusable OCI VCN with a private DNS view, a private zone, and a simple A record attached to the VCN resolver |

See [`examples/`](examples) for details.

---

## 🧠 Design Philosophy

- Explicit over implicit
- Small modules over monoliths
- DNS separated from VCN foundation
- Optimized for **learning, reuse, and composition**

This makes the module useful for:
- OCI private service naming
- platform networking labs
- private endpoint and shared service scenarios
- multicloud DNS design discussions

---

## 📌 Notes

- The module uses the VCN-associated private resolver by default and updates its attached views
- Managing resolver attachments means Terraform owns the full list of attached views configured through this module invocation
- The legacy `terraform-oci-private-dns` repository served as practical source material, but this module intentionally avoids bundling VCN, compute, and DNS concerns together
- RRsets are managed with `oci_dns_rrset`, which is a better fit than older per-record patterns

---

## 🌐 Learn More

Visit [FoggyKitchen.com](https://foggykitchen.com/) for OCI, multicloud, and Terraform/OpenTofu learning resources.

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](LICENSE) for more details.
