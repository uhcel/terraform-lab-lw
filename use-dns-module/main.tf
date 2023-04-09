module "dns-private-zone" {
  source  = "terraform-google-modules/cloud-dns/google"
  version = "4.0"
  project_id = "my-project"
  type       = "private"
  name       = "joonix.cloud."
  domain     = "joonix.cloud."

  private_visibility_config_networks = [
    "https://www.googleapis.com/compute/v1/projects/my-project/global/networks/my-vpc"
  ]

  recordsets = [
    {
      name    = ""
      type    = "NS"
      ttl     = 300
      records = [
        "127.0.0.1",
      ]
    },
    {
      name    = "localhost"
      type    = "A"
      ttl     = 300
      records = [
        "127.0.0.1",
      ]
    },
  ]
}

output "domain" {
    value = module.dns-private-zone.name
  
}