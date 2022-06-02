resource "openstack_compute_instance_v2" "dali" {
  count = can(var.nodes.dali.count) ? var.nodes.dali.count : local.volumes.dali.count

  name              = format("dali_%s", count.index)
  image_name        = var.nodes.dali.image_name
  flavor_name       = var.nodes.dali.flavor_name
  key_pair          = fileexists(var.keypair.public_key) && var.keypair.generate == true ? openstack_compute_keypair_v2.keypair[0].name : var.keypair.name
  security_groups   = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]
  availability_zone = can(var.nodes.dali.volume_availability_zone) ? var.nodes.dali.volume_availability_zone : element(local.volumes.dali.availability_zones, count.index)

  network {
    port = element(openstack_networking_port_v2.dali.*.id, count.index)
  }

  user_data = join("\n\n", concat([file("${path.module}/provisioner.sh")], [can(var.nodes.dali.user_data) ? file(var.nodes.dali.user_data) : ""]))
}

resource "openstack_compute_instance_v2" "dropzone" {
  count = can(var.nodes.dropzone.count) ? var.nodes.dropzone.count : local.volumes.dropzone.count

  name              = format("dropzone_%s", count.index)
  image_name        = var.nodes.dropzone.image_name
  flavor_name       = var.nodes.dropzone.flavor_name
  key_pair          = fileexists(var.keypair.public_key) && var.keypair.generate == true ? openstack_compute_keypair_v2.keypair[0].name : var.keypair.name
  security_groups   = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]
  availability_zone = can(var.nodes.dropzone.volume_availability_zone) ? var.nodes.dropzone.volume_availability_zone : element(local.volumes.dropzone.availability_zones, count.index)

  network {
    port = element(openstack_networking_port_v2.dropzone.*.id, count.index)
  }

  user_data = join("\n\n", concat([file("${path.module}/provisioner.sh")], [can(var.nodes.dropzone.user_data) ? file(var.nodes.dropzone.user_data) : ""]))
}

resource "openstack_compute_instance_v2" "esp" {
  count = can(var.nodes.esp.count) ? var.nodes.esp.count : local.volumes.esp.count

  name              = format("esp_%s", count.index)
  image_name        = var.nodes.esp.image_name
  flavor_name       = var.nodes.esp.flavor_name
  key_pair          = fileexists(var.keypair.public_key) && var.keypair.generate == true ? openstack_compute_keypair_v2.keypair[0].name : var.keypair.name
  security_groups   = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]
  availability_zone = can(var.nodes.esp.volume_availability_zone) ? var.nodes.esp.volume_availability_zone : element(local.volumes.esp.availability_zones, count.index)

  network {
    port = element(openstack_networking_port_v2.esp.*.id, count.index)
  }

  user_data = join("\n\n", concat([file("${path.module}/provisioner.sh")], [can(var.nodes.esp.user_data) ? file(var.nodes.esp.user_data) : ""]))
}

resource "openstack_compute_instance_v2" "roxie" {
  count = can(var.nodes.roxie.count) ? var.nodes.roxie.count : local.volumes.roxie.count

  name              = format("roxie_%s", count.index)
  image_name        = var.nodes.roxie.image_name
  flavor_name       = var.nodes.roxie.flavor_name
  key_pair          = fileexists(var.keypair.public_key) && var.keypair.generate == true ? openstack_compute_keypair_v2.keypair[0].name : var.keypair.name
  security_groups   = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]
  availability_zone = can(var.nodes.roxie.volume_availability_zone) ? var.nodes.roxie.volume_availability_zone : element(local.volumes.roxie.availability_zones, count.index)

  network {
    port = element(openstack_networking_port_v2.roxie.*.id, count.index)
  }

  user_data = join("\n\n", concat([file("${path.module}/provisioner.sh")], [can(var.nodes.roxie.user_data) ? file(var.nodes.roxie.user_data) : ""]))
}

resource "openstack_compute_instance_v2" "thor" {
  count = can(var.nodes.thor.count) ? var.nodes.thor.count : local.volumes.thor.count

  name              = format("thor_%s", count.index)
  image_name        = var.nodes.thor.image_name
  flavor_name       = var.nodes.thor.flavor_name
  key_pair          = fileexists(var.keypair.public_key) && var.keypair.generate == true ? openstack_compute_keypair_v2.keypair[0].name : var.keypair.name
  security_groups   = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]
  availability_zone = can(var.nodes.thor.volume_availability_zone) ? var.nodes.thor.volume_availability_zone : element(local.volumes.thor.availability_zones, count.index)

  network {
    port = element(openstack_networking_port_v2.thor.*.id, count.index)
  }

  user_data = join("\n\n", concat([file("${path.module}/provisioner.sh")], [can(var.nodes.thor.user_data) ? file(var.nodes.thor.user_data) : ""]))
}
