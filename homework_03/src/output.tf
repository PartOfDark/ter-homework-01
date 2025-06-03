output "all_vms_out" {
 value = [
    for vm in local.all_vms: {
    name = vm.name
    fqdn = vm.fqdn
    #id = vm.id am to lazy to add it in local
    }
  ] 
}
