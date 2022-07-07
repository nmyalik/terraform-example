output "public_subnet_ids" {
  value = module.subnets.public_subnet_ids
}

output "id" {
  value = module.sg.id
}