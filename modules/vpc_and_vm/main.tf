resource "google_compute_network" "vpc_network" {
  project                 = var.project_name
  name                    = var.vpc_name
  auto_create_subnetworks = true
  network_firewall_policy_enforcement_order = "BEFORE_CLASSIC_FIREWALL"
}


## Compute instance ###

resource "google_compute_instance" "default" {
  name         = "${var.instance_name}-new"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      // Ephemeral public IP
    }
  }


  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

 
}