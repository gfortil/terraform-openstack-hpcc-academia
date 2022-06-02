data "openstack_networking_network_v2" "network" {
  network_id = var.network.id
}

data "openstack_networking_subnet_v2" "subnet" {
  subnet_id = var.network.subnet.id
}
