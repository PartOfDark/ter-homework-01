resource "random_password" "any_uniq_name" {
  length = 16
}

resource "vault_generic_secret" "test" {
  path = "secret/test/subtest"
  data_json = jsonencode({
    just_for_fun = random_password.any_uniq_name.result
  })
}

data "vault_generic_secret" "test" {
  path = "secret/test/subtest"
}
