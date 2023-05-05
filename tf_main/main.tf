# TF fffv
module "vm_and_vpc" {
  source = "../modules/vpc_and_vm"

  vpc_name     = "new-vpc-terraform"
  project_name = "nw-on-prem-lab"
  instance_name  = "instance-terraform-module"

}
  
# terraform {
# backend "gcs" {
#   bucket  = "tfstate-lw-test"
#   prefix  = "terraform/state"
# }
# }
