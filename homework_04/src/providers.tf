terraform {
  required_version = ">= 1.8.4"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.89"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  vault = {
    source  = "hashicorp/vault"
    version = ">= 3.0"
  }
  }
}

provider "yandex" {
  service_account_key_file = file("~/.key.json")
}

provider "aws" {
  region                        = "us-east-1"
  skip_region_validation        = true
  skip_credentials_validation   = true
  skip_requesting_account_id    = true

  access_key                    = "test"
  secret_key                    = "test"
}

provider "vault" {
  address         = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token           = "education"
  # checkov:skip=CKV_SECRET_6: education
}

