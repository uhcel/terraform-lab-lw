# Enable compute engine APIs
resource "google_project_service" "compute_engine" {
  service = "compute.googleapis.com"
}

module "vm_and_vpc" {
  source = "../modules/vpc_and_vm"

  vpc_name     = "new-vpc-terraform"
  project_name = "prj-bootstrap-3259"
  instance_name  = "instance-terraform-module"

}
