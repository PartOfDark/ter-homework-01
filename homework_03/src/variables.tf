###cloud vars

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
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "ssh_root_key" {
  description = "SSH public key for root user"
  type        = string
}

###cloud vars
variable "vm_props" {
  type = object({ 
    family = string, 
    name = string,
    platform_id = string,
    preemptible = bool,
    nat = bool,
    serial_port_enable = number,
    cores = number,
    memory = number,
    core_fraction = number
    })
  default = {
    family = "ubuntu-2004-lts", 
    name = "netology-develop-platform-web",
    platform_id = "standard-v1",
    preemptible = true,
    nat = true,
    serial_port_enable = 1,
    cores = 2,
    memory = 1,
    core_fraction = 5}
  }

variable "each_db" {
  type = list(object({  vm_name=string,
                        cpu=number,
                        ram=number,
                        disk_volume=number,
                        core_fraction=number,
                        family=string}))
  default = [
    {
      vm_name = "main"
      cpu = 4 
      ram = 4 
      disk_volume = 20
      core_fraction = 5
      family = "ubuntu-2004-lts"
    },
    {
      vm_name = "replica"
      cpu = 2 
      ram = 2 
      disk_volume = 10
      core_fraction = 5
      family = "ubuntu-2004-lts"
    }
  ]
}
