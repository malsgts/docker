variable "aws_region" {
  default = "us-east-1"
}
variable "allowed_ssh_ips" {
  type        = list(string)
  description = "Lista de IPs/CIDRs permitidas para SSH"
}
variable "db_name" {
  default = "midatabase"
}
variable "db_username" {
  default = "admin"
}
variable "db_password" {
  description = "Contraseña del usuario de la base de datos"
  sensitive   = true
}