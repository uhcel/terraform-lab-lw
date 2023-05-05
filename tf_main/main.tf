# TF fffv
module "vm_and_vpc" {
  source = "../modules/vpc_and_vm"

  vpc_name     = "new-vpc-terraform"
  project_name = "prj-bootstrap-3259"
  instance_name  = "instance-terraform-module"

}
