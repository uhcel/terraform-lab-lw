variable "ids_name" {
  type        = string
  description = "Cloud IDS endpoint name"
  default     = ""

}
variable "ids_location" {
  type        = string
  description = "Cloud IDS location"
  default     = "europe-west2-c"

}

variable "ids_network" {
  type        = string
  description = "Cloud IDS network"
  default     = "shd-vpc-lw"

}
variable "ids_severity" {
  type        = string
  description = "Cloud IDS severity"
  default     = "INFORMATIONAL"

}