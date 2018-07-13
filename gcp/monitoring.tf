# Prometheus Server

# Instance for Prometheus server
resource "google_compute_instance" "factom-internal-monitoring" {
  name = "factom-internal-monitoring"
  machine_type = "n1-standard-1"
  zone = "${zone_a}"

  description = "Main Factom network guard node Iowa A"

  tags = ["factom-internal-monitoring-ingress", "factom-internal-monitoring-egress", "factom-main-ssh"]

  boot_disk {
     initialize_params {
       image = "ubuntu-1804-lts"
       type = "pd-ssd"
       size = "30"
     }
  }

  network_interface {
    network = "mainnet"
    access_config {
      // Ephemeral IP
    }
  }

  metadata {
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
}
