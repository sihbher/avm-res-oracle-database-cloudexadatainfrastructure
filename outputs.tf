# Module owners should include the full resource via a 'resource' output
# https://azure.github.io/Azure-Verified-Modules/specs/terraform/#id-tffr2---category-outputs---additional-terraform-outputs
output "resource" {
  description = "This is the full output for the resource."
  value       = azapi_resource.odaa_infra
}


output "resource_id" {
  description = "This is the ID of the resource."
  value       = azapi_resource.odaa_infra.id

}
