# output "control_plane_public_ip" {
#  value       = module.compute.control_plane_public_ip
#  description = "Public IP of the k3s Master Node"
# }

# output "worker_nodes_public_ips" {
#  value       = module.compute.worker_nodes_public_ips
#  description = "Public IPs of the k3s Worker Nodes"
# }

# output "control_plane_private_ip" {
#  value       = module.compute.control_plane_private_ip
#  description = "Private internal IP used by workers to register with the control plane"
# }
output "rds_endpoint" {
  description = "The public endpoint to connect to the database"
  value       = module.rds.db_endpoint
}
