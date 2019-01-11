terraform {
  required_version = ">= 0.11"
}

provider "google" {
  credentials = "${file("k8s-istio-218403-ab564efba079.json")}"
  project     = "k8s-istio-218403"
  region      = "us-east1"
}

resource "random_id" "instance_id" {
  byte_length = 8
}

resource "google_compute_instance" "default" {
  name         = "node-${random_id.instance_id.hex}"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  metadata_startup_script = "sudo apt-get update -y"

  metadata {
    sshKeys = "username:${file("~/.ssh/id_rsa.pub")}"
  }
}

/*
resource "google_compute_firewall" "default" {
  name = "instance-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["8080"]
  }
}
*/

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
