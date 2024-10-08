<!-- BEGIN_TF_DOCS -->
# avm-res-oracledatabase-cloudexadatainfrastructure
This repository contains a Terraform module for deploying Oracle Database Cloud Exadata Infrastructure using Azure Verified Modules (AVM). The module provisions scalable Oracle Cloud Exadata Infrastructure in an enterprise-ready configuration on Microsoft Azure.
## Known issues
- Idempotency Issue with Exadata Infrastructure documented [here](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/issues/33)
- Update/Changes. Oracle Exadata Infrastructure resource at this moment does not support updates, so every attempt to change any of its properties will trigger the destroy and recreation of the resource. Documented [here](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/issues/39) and [here](https://github.com/oci-landing-zones/terraform-oci-multicloud-azure/issues/40)
## Features
- Deploys Oracle Database Cloud Exadata Infrastructure on Azure
- Supports telemetry and monitoring
- Configurable maintenance windows
## Prerequisites
- Terraform >= 1.9.2
- Azure CLI
- An Azure subscription
## Requirements
The following requirements are needed by this module:
- <a name="requirement\_terraform"></a> [terraform](#requirement\\_terraform) (>= 1.9.2)
- <a name="requirement\_azapi"></a> [azapi](#requirement\\_azapi) (~> 1.14.0)
- <a name="requirement\_azurerm"></a> [azurerm](#requirement\\_azurerm) (~> 3.116.0)
- <a name="requirement\_modtm"></a> [modtm](#requirement\\_modtm) (~> 0.3)
- <a name="requirement\_random"></a> [random](#requirement\\_random) (~> 3.5)
## Usage
```hcl
terraform {
  required_version = ">= 1.9.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}
provider "azurerm" {
  features {}
  skip_provider_registration = true
}
locals {
  enable_telemetry = true
  location         = "eastus"
  tags = {
    scenario  = "Default"
    project   = "Oracle Database @ Azure"
    createdby = "ODAA Infra - AVM Module"
  }
  zone = "3"
}
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}
resource "azurerm_resource_group" "this" {
  location = local.location
  name     = "example-resource-group"
  tags     = local.tags
}
module "default" {
  source                               = "../../"
  location                             = local.location
  name                                 = "odaa-infra-${random_string.suffix.result}"
  display_name                         = "odaa-infra-${random_string.suffix.result}"
  resource_group_id                    = azurerm_resource_group.this.id
  zone                                 = local.zone
  compute_count                        = 2
  storage_count                        = 3
  shape                                = "Exadata.X9M"
  maintenance_window_leadtime_in_weeks = 0
  maintenance_window_preference        = "NoPreference"
  maintenance_window_patching_mode     = "Rolling"
  tags                                 = local.tags
  enable_telemetry                     = local.enable_telemetry
}
```

## Inputs
| Name                                 | Type        | Default Value      | Description                                                                 |
|--------------------------------------|-------------|--------------------|-----------------------------------------------------------------------------|
| `compute_count`                      | `number`    |                    | The number of compute nodes in the infrastructure.                          |
| `display_name`                       | `string`    |                    | The display name of the infrastructure.                                     |
| `location`                           | `string`    |                    | Azure region where the resource should be deployed.                         |
| `name`                               | `string`    |                    | The name of the Oracle Exadata Infrastructure resource.                     |
| `resource_group_id`                  | `string`    |                    | The resource group ID where the resources will be deployed.                 |
| `storage_count`                      | `number`    |                    | The number of storage servers in the infrastructure.                        |
| `zone`                               | `string`    |                    | The Availability Zone for the resource.                                     |
| `enable_telemetry`                   | `bool`      | `true`             | Controls whether telemetry is enabled.                                      |
| `maintenance_window_leadtime_in_weeks` | `number`    | `0`                | The maintenance window lead time in weeks.                                  |
| `maintenance_window_patching_mode`   | `string`    | `"Rolling"`        | The maintenance window patching mode.                                       |
| `maintenance_window_preference`      | `string`    | `"NoPreference"`   | The maintenance window preference.                                          |
| `shape`                              | `string`    | `"Exadata.X9M"`    | The shape of the infrastructure.                                            |
| `tags`                               | `map(string)` | `null`             | (Optional) Tags of the resource.                                            |
## Outputs
| Name         | Type   | Description                        |
|--------------|--------|------------------------------------|
| `resource`   | `any`  | This is the full output for the resource. |
| `resource_id`| `string` | This is the ID of the resource.   |
## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
## Contributing
Please read [CODE\_OF\_CONDUCT.md](CODE\_OF\_CONDUCT.md) for details on our code of conduct, and the process for submitting pull requests.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9.2)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 1.15.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 3.116.0)

- <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) (~> 0.3)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.5)

## Resources

The following resources are used by this module:

- [azapi_resource.odaa_infra](https://registry.terraform.io/providers/azure/azapi/latest/docs/resources/resource) (resource)
- [modtm_telemetry.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/resources/telemetry) (resource)
- [random_uuid.telemetry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) (resource)
- [azurerm_client_config.telemetry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) (data source)
- [modtm_module_source.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/data-sources/module_source) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_compute_count"></a> [compute\_count](#input\_compute\_count)

Description: The number of compute nodes in the infrastructure.

Type: `number`

### <a name="input_display_name"></a> [display\_name](#input\_display\_name)

Description: The display name of the infrastructure.

Type: `string`

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region where the resource should be deployed.

Type: `string`

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the the Oracle Exatada Infrastructure resource.

Type: `string`

### <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id)

Description: The resource group ID where the resources will be deployed.

Type: `string`

### <a name="input_storage_count"></a> [storage\_count](#input\_storage\_count)

Description: The number of storage servers in the infrastructure.

Type: `number`

### <a name="input_zone"></a> [zone](#input\_zone)

Description: The Availability Zone for the resource.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see <https://aka.ms/avm/telemetryinfo>.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_maintenance_window_leadtime_in_weeks"></a> [maintenance\_window\_leadtime\_in\_weeks](#input\_maintenance\_window\_leadtime\_in\_weeks)

Description: The maintenance window load time in weeks.

Type: `number`

Default: `0`

### <a name="input_maintenance_window_patching_mode"></a> [maintenance\_window\_patching\_mode](#input\_maintenance\_window\_patching\_mode)

Description: The maintenance window patching mode.

Type: `string`

Default: `"Rolling"`

### <a name="input_maintenance_window_preference"></a> [maintenance\_window\_preference](#input\_maintenance\_window\_preference)

Description: The maintenance window preference.

Type: `string`

Default: `"NoPreference"`

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description: A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.
- `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. This field is only used in cross-tenant scenario.
- `principal_type` - (Optional) The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_shape"></a> [shape](#input\_shape)

Description: The shape of the infrastructure.

Type: `string`

Default: `"Exadata.X9M"`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) Tags of the resource.

Type: `map(string)`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_resource"></a> [resource](#output\_resource)

Description: This is the full output for the resource.

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: This is the ID of the resource.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->