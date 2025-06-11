###cloud vars

variable "public_key" {
  type    = string
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-b"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "yc_iam_token" {
  type        = string
  description = "Яндекс.Cloud IAM токен (`yc iam create-token`)"
}
