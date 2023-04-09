terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.44.1"
    }
  }
}

provider "google" {
  project = "priv-host-lw"
  region  = "europe-west2"
  zone    = "europe-west2-c"
}

### Cloud IDS
/*
resource "google_compute_global_address" "service_range" {
    name          = "address"
    purpose       = "VPC_PEERING"
    address_type  = "INTERNAL"
    prefix_length = 16
    network       = "shd-vpc-lw"
}
resource "google_service_networking_connection" "private_service_connection" {
    network                 = "shd-vpc-lw"
    service                 = "servicenetworking.googleapis.com"
    reserved_peering_ranges = [google_compute_global_address.service_range.name]
}
*/

resource "google_cloud_ids_endpoint" "example-endpoint" {
  name     = "${var.ids_name}-new"
  location = var.ids_location
  network  = var.ids_network
  severity = "${var.ids_severity}"
}

output "lb_address" {
  value = google_cloud_ids_endpoint.example-endpoint.endpoint_forwarding_rule
}

output "network" {
  value = google_cloud_ids_endpoint.example-endpoint.network
}

output "id" {
  value = google_cloud_ids_endpoint.example-endpoint.id
}

##### Packet Mirroring
###   gcloud ids endpoints describe ids-ep-lw-tf --zone=europe-west2-c
###   endpointForwardingRule: https://www.googleapis.com/compute/v1/projects/ac4a069376c701fcdp-tp/regions/europe-west2/forwardingRules/ids-fr-ids-ep-avxih1ulxtuqkdfa
##### Currently

resource "google_compute_packet_mirroring" "foobar" {
  name        = "my-mirroring"
  depends_on  = [google_cloud_ids_endpoint.example-endpoint]
  description = "bar"
  network {
    url = "leszek-network"
  }
  collector_ilb {
    #  url = "https://www.googleapis.com/compute/v1/projects/ac4a069376c701fcdp-tp/regions/europe-west2/forwardingRules/ids-fr-ids-ep-aroaffw6fxsw1mvq"
    url = google_cloud_ids_endpoint.example-endpoint.endpoint_forwarding_rule
  }
  mirrored_resources {
    subnetworks {
      url = "ew-west2"
    }
  }
  filter {
    ip_protocols = ["tcp"]
    cidr_ranges  = ["10.10.0.0/16", "10.11.0.0/16"]
    direction    = "BOTH"
  }
}
