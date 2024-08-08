#====================================================================================================
# Cloud Exadata VM Cliuster variables
#====================================================================================================
variable "compute_count" {
  type        = number
  description = "The number of compute nodes in the infrastructure."
}

variable "display_name" {
  type        = string
  description = "The display name of the infrastructure."
}

variable "location" {
  type        = string
  description = "Azure region where the resource should be deployed."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the the Oracle Exatada Infrastructure resource."
}

variable "resource_group_id" {
  type        = string
  description = "The resource group ID where the resources will be deployed."
  nullable    = false
}

variable "storage_count" {
  type        = number
  description = "The number of storage servers in the infrastructure."
}

variable "zone" {
  type        = string
  description = "The Availability Zone for the resource."
  nullable    = false

  validation {
    condition     = can(regex("^[1-3]$", var.zone))
    error_message = "The zone must be a number between 1 and 3."
  }
}

# tflint-ignore: terraform_unused_declarations
variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "maintenance_window_leadtime_in_weeks" {
  type        = number
  default     = 0
  description = "The maintenance window load time in weeks."
}

variable "maintenance_window_patching_mode" {
  type        = string
  default     = "Rolling"
  description = "The maintenance window patching mode."
}

variable "maintenance_window_preference" {
  type        = string
  default     = "NoPreference"
  description = "The maintenance window preference."
}

#====================================================================================================
# AVM Interface variables
#====================================================================================================
# tflint-ignore: terraform_unused_declarations
variable "role_assignments" {
  type = map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
    principal_type                         = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.
- `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. This field is only used in cross-tenant scenario.
- `principal_type` - (Optional) The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.
  

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.
DESCRIPTION
  nullable    = false
}

variable "shape" {
  type        = string
  default     = "Exadata.X9M"
  description = "The shape of the infrastructure."
}

# tflint-ignore: terraform_unused_declarations
variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}
