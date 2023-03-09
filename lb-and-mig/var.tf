variable "project_id" {
  description = "The ID of the project to deploy the resources into."
  default = "nw-on-prem-lab"
}

variable "region" {
  description = "The region to deploy the resources into."
  default = "europe-west2"
}

variable "subnet_name" {
  description = "The name of the subnet to deploy the resources into."
  default = "ew-west22"
}

variable "instance_group_name" {
  description = "The name of the instance group to create."
  default = "mig-chat-gpt"
}

variable "instance_template_name" {
  description = "The name of the instance template to create."
  default = "web-server-template"
}