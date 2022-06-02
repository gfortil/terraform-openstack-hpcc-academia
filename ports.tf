resource "openstack_networking_port_v2" "dali" {
  count = can(var.nodes.dali.count) ? var.nodes.dali.count : local.volumes.dali.count

  name               = format("dali_%s", count.index)
  network_id         = data.openstack_networking_network_v2.network.id
  admin_state_up     = "true"
  security_group_ids = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]

  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
  }
}

resource "openstack_networking_port_v2" "dropzone" {
  count = can(var.nodes.dropzone.count) ? var.nodes.dropzone.count : local.volumes.dropzone.count

  name               = format("dropzone_%s", count.index)
  network_id         = data.openstack_networking_network_v2.network.id
  admin_state_up     = "true"
  security_group_ids = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]

  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
  }
}

resource "openstack_networking_port_v2" "esp" {
  count = can(var.nodes.esp.count) ? var.nodes.esp.count : local.volumes.esp.count

  name               = format("esp_%s", count.index)
  network_id         = data.openstack_networking_network_v2.network.id
  admin_state_up     = "true"
  security_group_ids = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]

  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
    ip_address = can(var.nodes.esp.ips) ? element(var.nodes.esp.ips, count.index) : null
  }
}

resource "openstack_networking_port_v2" "roxie" {
  count = can(var.nodes.roxie.count) ? var.nodes.roxie.count : local.volumes.roxie.count

  name               = format("roxie_%s", count.index)
  network_id         = data.openstack_networking_network_v2.network.id
  admin_state_up     = "true"
  security_group_ids = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]

  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
  }
}

resource "openstack_networking_port_v2" "thor" {
  count = can(var.nodes.thor.count) ? var.nodes.thor.count : local.volumes.thor.count

  name               = format("thor_%s", count.index)
  network_id         = data.openstack_networking_network_v2.network.id
  admin_state_up     = "true"
  security_group_ids = can(var.network.security_group_id) ? [var.network.security_group_id] : [openstack_networking_secgroup_v2.secgroup[0].id]

  fixed_ip {
    subnet_id  = data.openstack_networking_subnet_v2.subnet.id
  }
}
