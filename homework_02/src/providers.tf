terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.142.0"

    }
  }
  required_version = ">=1.5"
}

provider "yandex" {
  # token     = var.token
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.default_zone
  service_account_key_file = file("~/.key.json")
}
