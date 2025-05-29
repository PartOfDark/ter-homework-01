data "yandex_vpc_subnet" "default" {
  name      = "default-ru-central1-b"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm" {
  name        = "tf-demo-vm"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.default.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/elliot/.ssh/id_ed25519.pub")}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    agent = true
    host        = self.network_interface[0].nat_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y docker.io",
      "sudo usermod -aG docker ubuntu",
    ]
  }
}

resource "random_password" "root_pass" {
  length  = 16
  special = true
}

resource "random_password" "user_pass" {
  length  = 16
  special = true
}

resource "docker_image" "mysql" {
  provider = docker.remote
  name     = "mysql:8"
  depends_on = [yandex_compute_instance.vm]
}

resource "docker_container" "mysql" {
  provider = docker.remote
  name     = "mysql-server"
  image    = docker_image.mysql.name

  ports {
    internal = 3306
    external = 3306
    ip  = "127.0.0.1"
  }

  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.root_pass.result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.user_pass.result}",
    "MYSQL_ROOT_HOST=%",
  ]
}
