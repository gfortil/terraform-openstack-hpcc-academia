resource "random_password" "password" {
  for_each = var.users
  length           = 16
}

resource "openstack_compute_keypair_v2" "keypair" {
  count      = var.keypair.generate ? 1 : 0
  name       = var.keypair.name
  public_key = fileexists(var.keypair.public_key) && var.keypair.generate == false ? file(var.keypair.public_key) : null
}

resource "openstack_networking_secgroup_v2" "secgroup" {
  count = can(var.network.security_group_id) ? 0 : 1
  name  = "custom-security-group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rules" {
  for_each = local.security_groups

  direction         = each.value.direction
  ethertype         = each.value.ethertype
  protocol          = each.value.protocol
  port_range_min    = try(each.value.port_range_min, null)
  port_range_max    = try(each.value.port_range_max, null)
  remote_ip_prefix  = each.value.remote_ip_prefix
  security_group_id = can(var.network.security_group_id) ? var.network.security_group_id : openstack_networking_secgroup_v2.secgroup[0].id
}


resource "openstack_compute_volume_attach_v2" "dali" {
  count = can(var.nodes.dali.count) ? var.nodes.dali.count : local.volumes.dali.count

  instance_id = element(openstack_compute_instance_v2.dali.*.id, count.index)
  volume_id   = can(var.nodes.dali.attach_volume_ids) ? element(var.nodes.dali.attach_volume_ids, count.index) : element(local.volumes.dali.volume_ids, count.index)
}

resource "openstack_compute_volume_attach_v2" "dropzone" {
  count = can(var.nodes.dropzone.count) ? var.nodes.dropzone.count : local.volumes.dropzone.count

  instance_id = element(openstack_compute_instance_v2.dropzone.*.id, count.index)
  volume_id   = can(var.nodes.dropzone.attach_volume_ids) ? element(var.nodes.dropzone.attach_volume_ids, count.index) : element(local.volumes.dropzone.volume_ids, count.index)
}

resource "openstack_compute_volume_attach_v2" "esp" {
  count = can(var.nodes.esp.count) ? var.nodes.esp.count : local.volumes.esp.count

  instance_id = element(openstack_compute_instance_v2.esp.*.id, count.index)
  volume_id   = can(var.nodes.esp.attach_volume_ids) ? element(var.nodes.esp.attach_volume_ids, count.index) : element(local.volumes.esp.volume_ids, count.index)
}

resource "openstack_compute_volume_attach_v2" "thor" {
  count = can(var.nodes.thor.count) ? var.nodes.thor.count : local.volumes.thor.count

  instance_id = element(openstack_compute_instance_v2.thor.*.id, count.index)
  volume_id   = can(var.nodes.thor.attach_volume_ids) ? element(var.nodes.thor.attach_volume_ids, count.index) : element(local.volumes.thor.volume_ids, count.index)
}

resource "openstack_compute_volume_attach_v2" "roxie" {
  count = can(var.nodes.roxie.count) ? var.nodes.roxie.count : local.volumes.roxie.count

  instance_id = element(openstack_compute_instance_v2.roxie.*.id, count.index)
  volume_id   = can(var.nodes.roxie.attach_volume_ids) ? element(var.nodes.roxie.attach_volume_ids, count.index) : element(local.volumes.roxie.volume_ids, count.index)
}



