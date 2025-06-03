data "yandex_compute_image" "ubuntu" {
  family = var.vm_props["family"]
}
resource "yandex_compute_instance" "platform" {
  count = 2
  name        = "${var.vm_props["name"]}-${count.index + 1}"
  platform_id = var.vm_props.platform_id
  resources {
    cores         = var.vm_props["cores"]
    memory        = var.vm_props["memory"]
    core_fraction = var.vm_props["core_fraction"]
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_props["preemptible"]
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_props["nat"]
    security_group_ids  = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.vm_props["serial_port_enable"]
    ssh-keys           = "ubuntu:${var.ssh_root_key}"
  }
  depends_on = [yandex_compute_instance.db]
}

