# OCI Private DNS with Terraform/OpenTofu - Training Examples

This directory contains runnable examples for the **terraform-oci-fk-private-dns** module.
The examples focus on practical OCI private DNS patterns built around private views, private zones, RRsets, and resolver view attachment.

These examples are part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and are used across OCI and multicloud courses covering networking, private service naming, resolver behavior, and composable infrastructure design.

---

## Published Examples

| Example | Title | Key Topics |
|:-------:|:------|:-----------|
| 01 | **Basic Private Zone** | private DNS view, private zone, A record, VCN-associated resolver, `terraform-oci-fk-vcn` integration |

---

## How to Use

The example directory contains:
- Terraform/OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the goal of the example
- A minimal, runnable architecture

To run the basic private zone example:

```bash
cd examples/01-basic-private-zone
cp terraform.tfvars.example terraform.tfvars
tofu init
tofu plan
tofu apply
```

---

## Design Principles

- One example = one architectural goal
- No unused or placeholder resources
- Clear separation of concerns between networking and private DNS
- Examples designed to compose cleanly with modules such as VCN

---

## Related Resources

- [FoggyKitchen OCI Private DNS Module (terraform-oci-fk-private-dns)](../)
- [FoggyKitchen OCI VCN Module (terraform-oci-fk-vcn)](https://github.com/foggykitchen/terraform-oci-fk-vcn)
- [FoggyKitchen Legacy OCI Private DNS Repository (terraform-oci-private-dns)](https://github.com/mlinxfeld/terraform-oci-private-dns)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](../LICENSE) for details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
