locals {
  webservers = [
    for vm in yandex_compute_instance.platform :
    {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]

  databases = [
    for vm in yandex_compute_instance.db :
    {
      name        = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]

  storage = [
    {
      name        = yandex_compute_instance.disk_vm.name
      external_ip = yandex_compute_instance.disk_vm.network_interface[0].nat_ip_address
      fqdn        = yandex_compute_instance.disk_vm.fqdn
    }
  ]

  all_vms = concat(local.webservers, local.databases, local.storage)
}

