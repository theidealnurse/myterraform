# Creating the variable blocks

# For project region
variable "project_region" {
  description = "Assign the Aws region for this project"
  type        = string
  default     = "eu-west-2"
}

# for inbound port
variable "inbound_ports" {
  description = "Security groups inbound ports"
  type        = list(number)
  default     = [22,80,443]
}

# for domain names
variable "domain_name" {
  description = "Describes the domain and subdomain names"
  type        = string
  default     = "temi.live"
}



# for ssh key
variable "ssh_key" {
  description = "SSH Key name"
  type = string
}