module "s3" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=master"

  bucket_name = "my-demo-bucket"
}

