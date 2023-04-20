variable "project_name" {
  type        = string
  description = "Project name"
  default     = "nw-on-prem-lab"

}
variable "vpc_name" {
  type        = string
  description = "VPC Network name"
  default     = "new-vpclw-tf-1"

}

variable "instance_name" {
  type        = string
  description = "GCE Instance name"
  default     = "new-instance-test-1"

}
