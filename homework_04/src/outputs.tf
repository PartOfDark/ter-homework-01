output "debug_public_key" {
  value = local.public_key
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.test.data["just_for_fun"])}"
}

