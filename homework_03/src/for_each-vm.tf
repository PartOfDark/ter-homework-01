resource "yandex_compute_instance" "db" {
 for_each = {
    for vm in var.each_db : vm.vm_name => vm
} 
  name = each.key
  zone = var.default_zone
  
  resources {
  cores         = each.value.cpu
  memory        = each.value.ram
  core_fraction = each.value.core_fraction
}

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]

  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_root_key}"
  }
  

}
