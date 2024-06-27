# terraform-google-bigtable

This terraform module is used to create big table resources such as big table instance and tables

### Assumptions and prerequisites
This module assumes that below mentioned prerequisites are in place before consuming the module.

- To deploy this blueprint you must have an active billing account and billing permissions.
- APIs are enabled
- Permissions are available
## Usage

Basic usage of this module is as follows:

```hcl
module "bigtable" {
  source  = "terraform-google-modules/bigtable/google"
  version = "~> 0.1"

  project_id  = "<PROJECT ID>"
  bucket_name = "gcs-test-bucket"
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deletion\_protection | Whether or not to allow Terraform to destroy the instance | `bool` | `true` | no |
| display\_name | The human-readable display name of the Bigtable instance. Defaults to the instance name | `string` | n/a | yes |
| labels | labels associated to the Bigtable instance. | `map(string)` | `{}` | no |
| name | The unique name of the Bigtable instance. | `string` | n/a | yes |
| project\_id | The ID of the project in which the resource belongs | `string` | n/a | yes |
| storage\_type | The storage type to use. One of SSD or HDD. Defaults to SSD | `string` | `"SSD"` | no |
| tables | Tables to created in the Bigtable instance. | <pre>map(object({<br>    table_name              = string<br>    split_keys              = optional(list(string))<br>    deletion_protection     = optional(string)<br>    change_stream_retention = optional(number)<br>    column_family = optional(map(object({<br>      family = string<br>      }))<br>    )<br>  }))</pre> | `{}` | no |
| zones | Zones of the Bigtable cluster. | <pre>map(object({<br>    zone         = string<br>    cluster_id   = string<br>    num_nodes    = optional(number)<br>    kms_key_name = optional(string)<br>    autoscaling_config = optional(object({<br>      min_nodes      = number<br>      max_nodes      = number<br>      cpu_target     = number<br>      storage_target = optional(number)<br>    }))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | Bigtable instance id |
| instance\_name | Bigtable instance name |
| table\_ids | List of table being provisioned |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.13
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v3.0

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Storage Admin: `roles/storage.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

## Security Disclosures

Please see our [security disclosure process](./SECURITY.md).
