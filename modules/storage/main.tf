resource "random_shuffle" "dali_availability_zones" {
  input = var.volumes.dali.availability_zones
}

resource "random_shuffle" "dropzone_availability_zones" {
  input = var.volumes.dropzone.availability_zones
}

resource "random_shuffle" "esp_availability_zones" {
  input = var.volumes.esp.availability_zones
}

resource "random_shuffle" "thor_availability_zones" {
  input = var.volumes.thor.availability_zones
}

resource "random_shuffle" "roxie_availability_zones" {
  input = var.volumes.roxie.availability_zones
}

resource "openstack_blockstorage_volume_v3" "dali" {
  count = var.volumes.dali.count

  name              = format("dali_%s", count.index)
  size              = var.volumes.dali.size
  availability_zone = element(random_shuffle.dali_availability_zones.result, count.index)

  lifecycle {
    prevent_destroy = false
  }
}

resource "openstack_blockstorage_volume_v3" "dropzone" {
  count = var.volumes.dropzone.count

  name              = format("dropzone_%s", count.index)
  size              = var.volumes.dropzone.size
  availability_zone = element(random_shuffle.dropzone_availability_zones.result, count.index)

  lifecycle {
    prevent_destroy = false
  }
}

resource "openstack_blockstorage_volume_v3" "esp" {
  count = var.volumes.esp.count

  name              = format("esp_%s", count.index)
  size              = var.volumes.esp.size
  availability_zone = element(random_shuffle.esp_availability_zones.result, count.index)

  lifecycle {
    prevent_destroy = false
  }
}

resource "openstack_blockstorage_volume_v3" "thor" {
  count = var.volumes.thor.count

  name              = format("thor_%s", count.index)
  size              = var.volumes.thor.size
  availability_zone = element(random_shuffle.thor_availability_zones.result, count.index)

  lifecycle {
    prevent_destroy = false
  }
}

resource "openstack_blockstorage_volume_v3" "roxie" {
  count = var.volumes.roxie.count

  name              = format("roxie_%s", count.index)
  size              = var.volumes.roxie.size
  availability_zone = element(random_shuffle.thor_availability_zones.result, count.index)

  lifecycle {
    prevent_destroy = false
  }
}
