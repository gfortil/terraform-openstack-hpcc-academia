locals {
  volumes = {
    thor = {
      volume_ids         = openstack_blockstorage_volume_v3.thor[*].id
      count              = var.volumes.thor.count
      availability_zones = openstack_blockstorage_volume_v3.thor[*].availability_zone
    }

    dali = {
      volume_ids         = openstack_blockstorage_volume_v3.dali[*].id
      count              = var.volumes.dali.count
      availability_zones = openstack_blockstorage_volume_v3.dali[*].availability_zone
    }

    esp = {
      volume_ids         = openstack_blockstorage_volume_v3.esp[*].id
      count              = var.volumes.esp.count
      availability_zones = openstack_blockstorage_volume_v3.esp[*].availability_zone
    }

    dropzone = {
      volume_ids         = openstack_blockstorage_volume_v3.dropzone[*].id
      count              = var.volumes.dropzone.count
      availability_zones = openstack_blockstorage_volume_v3.dropzone[*].availability_zone
    }

    roxie = {
      volume_ids         = openstack_blockstorage_volume_v3.roxie[*].id
      count              = var.volumes.roxie.count
      availability_zones = openstack_blockstorage_volume_v3.roxie[*].availability_zone
    }
  }

  output_file = templatefile(
    "./output.tftpl", {
      thor_volume_ids     = local.volumes.thor.volume_ids, thor_count = local.volumes.thor.count, thor_availability_zones = local.volumes.thor.availability_zones,
      dali_volume_ids     = local.volumes.dali.volume_ids, dali_count = local.volumes.dali.count, dali_availability_zones = local.volumes.dali.availability_zones,
      roxie_volume_ids    = local.volumes.roxie.volume_ids, roxie_count = local.volumes.roxie.count, roxie_availability_zones = local.volumes.roxie.availability_zones,
      esp_volume_ids      = local.volumes.esp.volume_ids, esp_count = local.volumes.esp.count, esp_availability_zones = local.volumes.esp.availability_zones,
      dropzone_volume_ids = local.volumes.dropzone.volume_ids, dropzone_count = local.volumes.dropzone.count, dropzone_availability_zones = local.volumes.dropzone.availability_zones
  })
}
