
resource "azapi_resource" "odaa_infra" {
  type      = "Oracle.Database/cloudExadataInfrastructures@2023-09-01"
  parent_id = var.resource_group_id
  name      = var.name

  timeouts {
    create = "1h30m"
    delete = "20m"
  }

  body = {
    "location" : var.location,
    "zones" : [
      var.zone
    ],

    "tags" : var.tags,
    "properties" : {
      "computeCount" : var.compute_count,
      "displayName" : var.display_name,
      "maintenanceWindow" : {
        "leadTimeInWeeks" : var.maintenance_window_leadtime_in_weeks,
        "preference" : var.maintenance_window_preference,
        "patchingMode" : var.maintenance_window_patching_mode
      },
      "shape" : var.shape,
      "storageCount" : var.storage_count,
    }
  }
  schema_validation_enabled = false
  #depends_on = [ data.azurerm_resource_group.rg ]
}

