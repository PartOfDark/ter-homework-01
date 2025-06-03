resource "yandex_compute_disk" "data_disks" {
  count = 3

  name = "data-disk-${count.index}"
  size = 1 
  type = "network-hdd"
  zone = var.default_zone
}

resource "yandex_compute_instance" "disk_vm" {
  name        = "${var.vm_props["name"]}_with_disks"
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.data_disks

    content {
      disk_id = secondary_disk.value.id 
      auto_delete = true
    }
  }

  metadata = {
    serial-port-enable = var.vm_props["serial_port_enable"]
    ssh-keys           = "ubuntu:${var.ssh_root_key}"
  }
  depends_on = [yandex_compute_instance.db]
}

