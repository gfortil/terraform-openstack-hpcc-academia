locals {
  security_groups = { port_22 = { direction = "ingress", ethertype = "IPv4", protocol = "tcp", port_range_min = 22, port_range_max = 22, remote_ip_prefix = "0.0.0.0/0" },
    port_icmp = { direction = "ingress", ethertype = "IPv4", protocol = "icmp", remote_ip_prefix = "0.0.0.0/0" },
    port_80   = { direction = "ingress", ethertype = "IPv4", protocol = "tcp", port_range_min = 80, port_range_max = 80, remote_ip_prefix = "0.0.0.0/0" },
    port_443  = { direction = "ingress", ethertype = "IPv4", protocol = "tcp", port_range_min = 443, port_range_max = 443, remote_ip_prefix = "0.0.0.0/0" },
    port_8080 = { direction = "ingress", ethertype = "IPv4", protocol = "tcp", port_range_min = 8080, port_range_max = 8080, remote_ip_prefix = "0.0.0.0/0" },
  }

  dali_ips     = tomap({ for k in openstack_networking_port_v2.dali : k.name => k.all_fixed_ips })
  esp_ips      = tomap({ for k in openstack_networking_port_v2.esp : k.name => k.all_fixed_ips })
  dropzone_ips = tomap({ for k in openstack_networking_port_v2.dropzone : k.name => k.all_fixed_ips })
  thor_ips     = tomap({ for k in openstack_networking_port_v2.thor : k.name => k.all_fixed_ips })
  roxie_ips    = tomap({ for k in openstack_networking_port_v2.roxie : k.name => k.all_fixed_ips })

  private_key = try(sensitive(openstack_compute_keypair_v2.keypair[0].private_key), null)

  volumes = jsondecode(file("./modules/storage/bin/outputs.json"))

  user_list = [for k, v in var.users : k]
  users = jsondecode(
    [for k, v in var.users : templatefile(
      "./users.tftpl",
     {
       full_name = k, scope = v.scope,
       institution = v.institution, 
       username = v.username, 
       password = can(v.password) ? v.password:random_password.password[index(local.user_list, k)]
     })
    ])

}
