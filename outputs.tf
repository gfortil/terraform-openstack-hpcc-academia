# output "VM_IPs" {
#   value = local.vm_ips
# }

resource "local_sensitive_file" "private_key" {
  count             = var.keypair.generate ? 1 : 0
  content = openstack_compute_keypair_v2.keypair[0].private_key
  filename          = "${path.module}/${var.keypair.name}.pem"
  file_permission   = 600
}
