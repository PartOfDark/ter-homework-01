
variable "cloud_id" {
  type        = string
  default = "b1g4rrcf3jq0fkd1d7h1"
}

variable "folder_id" {
  type        = string
  default = "b1g3q0h4o0jqeg72nsen"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-b"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

#variable "vms_ssh_root_key" {
#  type        = string
#  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIoyFiZFKSNpIRogzmguhaKd+stXlkzpyFQtPhRdKg9Y elliot@El69"
#  description = "ssh-keygen -t ed25519"
#}

