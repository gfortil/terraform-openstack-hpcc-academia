# output "volumes" {
#   value = openstack_blockstorage_volume_v3.volumes[*]
# }

resource "local_file" "output" {
  content  = local.output_file
  filename = "${path.module}/bin/outputs.json"
}
