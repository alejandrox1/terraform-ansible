terraform {
  required_version = ">= 0.11"
}

provider "google" {
  credentials = "${file("k8s-istio-218403-ab564efba079.json")}"
  project     = "k8s-istio-218403"
  region      = "us-east1"
}

resource "google_compute_instance_group_manager" "nodes" {
  name               = "nodes-igm"
  base_instance_name = "node"
  instance_template  = "${google_compute_instance_template.nodes.self_link}"
  update_strategy    = "NONE"
  zone               = "us-east1-b"
  target_size        = 3
}

resource "google_compute_instance_template" "nodes" {
  name_prefix  = "node-template-"
  machine_type = "n1-standard-1"

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"
  }

  lifecycle {
    create_before_destroy = true
  }

  metadata {
    sshKeys = "username:${file("~/.ssh/id_rsa.pub")}"
  }
}

output "ips" {
  value = "${google_compute_instance_group_manager.nodes.instance_group}"
}
