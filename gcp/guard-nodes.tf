/*
Creates guard nodes for main network
*/

# Instance for guard node A
resource "google_compute_instance" "factom-guard-node-a" {
  name = "factom-guard-node-a"
  machine_type = "${guard_node_machine_type}"
  zone = "zone_a"

  description = "Main Factom network guard node A"

  tags = ["factom-guard-ingress", "factom-guard-egress", "factom-main-ssh", "factom-firewall-monitoring-export-egress", "factom-internal-monitoring-export-ingress"]

  boot_disk {
     initialize_params {
       image = "ubuntu-1804-lts"
       type = "pd-ssd"
       size = "200"
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

#Instance for guard node B
resource "google_compute_instance" "factom-guard-node-b" {
  name = "factom-guard-node-b"
  machine_type = "${var.guard_node_machine_type}"
  zone = "${var.zone_b}"

  description = "Main Factom network guard node B"

  tags = ["factom-guard-ingress", "factom-guard-egress", "factom-main-ssh", "factom-firewall-monitoring-export-egress", "factom-internal-monitoring-export-ingress"]

  boot_disk {
     initialize_params {
       image = "ubuntu-1804-lts"
       type = "pd-ssd"
       size = "100"
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
