output "ip_output" {
  value = [{
    instance_name = yandex_compute_instance.platform.name
    full_name = local.full_name_web
    external_ip   = yandex_compute_instance.platform.network_interface[0].nat_ip_address
    fqdn          = coalesce(
                      yandex_compute_instance.platform.fqdn,
                      yandex_compute_instance.platform.hostname,
                      ""
                    )
  },
{
    instance_name = yandex_compute_instance.db.name
    full_name = local.full_name_db
    external_ip   = yandex_compute_instance.db.network_interface[0].nat_ip_address
    fqdn          = coalesce(
                      yandex_compute_instance.db.fqdn,
                      yandex_compute_instance.db.hostname,
                      ""
                    )
  }
]
}

