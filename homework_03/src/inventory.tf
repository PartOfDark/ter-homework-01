resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"

  content = templatefile("${path.module}/inventory.tpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
}

