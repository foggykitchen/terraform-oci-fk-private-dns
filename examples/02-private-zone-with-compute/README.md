# Example 02: Private DNS With OCI Compute

In this example, we deploy **one Oracle Cloud Infrastructure (OCI) VCN**, create a **private DNS view** and **private zone**, and then launch a **single compute instance** with `terraform-oci-fk-compute` inside the same network.

The example demonstrates that a workload running in the VCN can resolve a private DNS record through the VCN-associated resolver, while still exposing a simple public HTTP endpoint for easy verification.

---

## 🧭 Architecture Overview

This deployment creates:

- One VCN in a single OCI region:
  - `fk-private-dns-compute-vcn` (`10.40.0.0/16`)
- One public subnet:
  - `fk-private-dns-compute-public` (`10.40.10.0/24`)
- One private DNS view
- One private DNS zone:
  - `fk.internal`
- One private A record:
  - `app.fk.internal -> 10.40.10.10`
- One OCI compute instance launched with `terraform-oci-fk-compute`
  - static private IP `10.40.10.10`
  - public IP for SSH and HTTP verification

This example keeps DNS and compute responsibilities separated, but composes them in a realistic application-style flow.
The instance uses the private DNS record from inside the VCN and publishes the resolved value on a demo web page.

---

## 🚀 Deployment Steps

Initialize and apply the Terraform/OpenTofu configuration:

```bash
cp terraform.tfvars.example terraform.tfvars
tofu init
tofu plan
tofu apply
```

After a successful deployment, Terraform will output:

- the VCN ID
- the private resolver ID
- the private view IDs
- the private zone IDs
- the compute instance ID
- the instance private IP
- the instance public IP

---

## 🖼️ Runtime Verification

After deployment, open the instance public IP in a browser.
The demo page should show:

- the instance hostname
- the instance private IP
- the private DNS name `app.fk.internal`
- the IP address resolved for that name from inside the VCN

If `Resolved IP inside VCN` shows `10.40.10.10`, the private resolver, view attachment, zone, and RRset are working as intended for workloads inside the network.

You can also verify over SSH:

```bash
ssh opc@<instance_public_ip>
getent hosts app.fk.internal
```

---

## 🧠 Design Notes

- The DNS record uses a static private IP so the name can exist before the instance boots
- The compute module depends on the private DNS module to avoid DNS timing issues during cloud-init
- The public IP exists only for operator convenience and demo verification
- The actual DNS resolution path remains private and VCN-scoped

This is a practical building block for:

- internal service naming
- early-stage application environment demos
- validation of resolver attachment and private zone behavior

---

## 🧹 Cleanup

To remove all resources created by this example:

```bash
tofu destroy
```

---

## ✅ Summary

This example demonstrates:

- how to create a private DNS view, zone, and A record in OCI
- how to deploy a compute instance with `terraform-oci-fk-compute`
- how to point a private DNS record at a workload private IP
- how to verify private DNS resolution from inside the VCN

---

## 🌐 Learn More

Visit [FoggyKitchen.com](https://foggykitchen.com/) for OCI, multicloud, and Terraform/OpenTofu learning resources.

---

## 🪪 License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.  
See [LICENSE](../../LICENSE) for more details.

---

© 2026 [FoggyKitchen.com](https://foggykitchen.com) - Cloud. Code. Clarity.
