# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

### Create the subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = "on-prem-vpc"
}

### Create the instance template
resource "google_compute_instance_template" "template" {
  name         = var.instance_template_name
  description  = "Instance template for the managed instance group"
  machine_type = "n1-standard-1"

  disk {
    source_image      = "debian-cloud/debian-11"
    auto_delete       = true
    boot              = true
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.self_link
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && sudo service apache2 start"
}

# Create the managed instance group
resource "google_compute_instance_group_manager" "group" {
  name               = var.instance_group_name
  base_instance_name = "instance"
  zone               = "${var.region}-a"
  target_size        = 2

  version {
    instance_template = google_compute_instance_template.template.self_link
  }

  named_port {
    name = "http"
    port = 80
  }
}

# Create the health check
resource "google_compute_http_health_check" "http_health_check" {
  name               = "http-health-check"
  request_path       = "/"
  check_interval_sec = 10
  timeout_sec        = 5
}

# Create the backend service
resource "google_compute_backend_service" "backend_service" {
  name               = "backend-service"
  health_checks      = [google_compute_http_health_check.http_health_check.self_link]
  protocol           = "HTTP"
  port_name          = "http"
  timeout_sec        = 5
  enable_cdn         = false

  backend {
    group = google_compute_instance_group_manager.group.self_link
  }
}

# Create the URL map
resource "google_compute_url_map" "url_map" {
  name            = "url-map"
  default_service = google_compute_backend_service.backend_service.self_link

  host_rule {
    hosts = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name = "allpaths"

    default_service = google_compute_backend_service.backend_service.self_link

    path_rule {
      paths        = ["/*"]
      service      = google_compute_backend_service.backend_service.self_link
    }
  }
}

# Create the internal HTTP load balancer
#resource "google_compute_internal_lb" "internal_lb" {
#  name            = "internal-lb"
#  region          = var.region
#  subnetwork      = google_compute_subnetwork.subnet
#}