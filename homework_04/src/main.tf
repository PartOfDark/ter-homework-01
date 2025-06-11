module "vpc_dev" {
  source       = "../modules/vpc"
  vpc_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
}

#resource "yandex_vpc_network" "develop" {
#  name = var.vpc_name
#}
#resource "yandex_vpc_subnet" "develop" {
#  name           = var.vpc_name
#  zone           = var.default_zone
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = var.default_cidr
#}

module "marketing" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [module.vpc_dev.subnet_ids[0].zone]
  subnet_ids     = [module.vpc_dev.subnet_ids[0].id]
  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"

  public_ip      = true
  labels = { 
    project = "marketing"
     }


  metadata = {
    user-data          = data.template_file.cloudinit.rendered 
    serial-port-enable = 1
    ssh-keys           = "ubuntu=${local.public_key}"
  }

}

module "analytics" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  network_id     = module.vpc_dev.network_id
  subnet_zones   = [module.vpc_dev.subnet_ids[0].zone]
  subnet_ids     = [module.vpc_dev.subnet_ids[0].id]
  instance_name  = "analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true


  labels = { 
    project = "analytics"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered 
    serial-port-enable = 1
    ssh-keys           = "ubuntu=${local.public_key}"
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    public_key = local.public_key
  }
}

