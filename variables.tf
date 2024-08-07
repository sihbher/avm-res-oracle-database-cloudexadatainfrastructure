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

#====================================================================================================
# Cloud Exadata VM Cliuster variables
#====================================================================================================
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

# remove only if not supported by the resource
# tflint-ignore: terraform_unused_declarations
variable "customer_managed_key" {
  type = object({
    key_vault_resource_id = string
    key_name              = string
    key_version           = optional(string, null)
    user_assigned_identity = optional(object({
      resource_id = string
    }), null)
  })
  default     = null
  description = <<DESCRIPTION
A map describing customer-managed keys to associate with the resource. This includes the following properties:
- `key_vault_resource_id` - The resource ID of the Key Vault where the key is stored.
- `key_name` - The name of the key.
- `key_version` - (Optional) The version of the key. If not specified, the latest version is used.
- `user_assigned_identity` - (Optional) An object representing a user-assigned identity with the following properties:
  - `resource_id` - The resource ID of the user-assigned identity.
DESCRIPTION  
}

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

variable "zone" {
  type        = string
  default     = "3"
  description = "The Availability Zone for the resource."

  validation {
    condition     = can(regex("^[1-3]$", var.zone))
    error_message = "The zone must be a number between 1 and 3."
  }
}
