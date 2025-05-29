terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.142.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "yandex" {
  service_account_key_file = "/home/elliot/.key.json"
  zone = "ru-central1-b"
}


provider "docker" {
  alias    = "remote"
  host     = "ssh://ubuntu@${yandex_compute_instance.vm.network_interface[0].nat_ip_address}:22"
  ssh_opts = [
    "-i", file("/home/elliot/.ssh/id_ed25519"),
    "-o", "StrictHostKeyChecking=no",
  ]
}

