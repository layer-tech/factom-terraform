/*
This creates disks and compute instances for mainnet authority nodes
*/

# Disk for node A
resource "google_compute_disk" "factom-main-node-disk-a" {
  name = "factom-main-node-disk-iowa"
  type = "pd-ssd"
  zone = "${var.zone_a}"
  size = "200"
}

# Disk for node B
resource "google_compute_disk" "factom-main-node-disk-b" {
  name = "factom-main-node-disk-carolina"
  type = "pd-ssd"
  zone = "${var.zone_b}"
  size = "200"
}

# Instance for node A
resource "google_compute_instance" "factom-auth-node-a" {
  name = "factom-auth-node-a"
  machine_type = "${var.auth_node_machine_type}"
  zone = "${var.zone_a}"

  description = "Main Factom network authority node A"

  tags = ["factom-auth-ingress", "factom-auth-egress", "factom-main-ssh", "factom-firewall-monitoring-export-egress", "factom-internal-monitoring-export-ingress"]

  boot_disk {
     initialize_params {
       image = "ubuntu-1804-lts"
       type = "pd-ssd"
     }
  }

  network_interface {
    network = "mainnet"
    access_config {
      // Ephemeral IP
    }
  }

  attached_disk {
    source = "factom-main-node-disk-a"
  }

  metadata {
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
}

# Instance for authority node B
resource "google_compute_instance" "factom-auth-node-b" {
  name = "factom-auth-node-b"
  machine_type = "${var.auth_node_machine_type}"
  zone = "${var.zone_b}"

  description = "Main Factom network authority node B"

  tags = ["factom-auth-ingress", "factom-auth-egress", "factom-main-ssh", "factom-firewall-monitoring-export-egress", "factom-internal-monitoring-export-ingress"]

  boot_disk {
     initialize_params {
       image = "ubuntu-1804-lts"
       type = "pd-ssd"
     }
  }

  network_interface {
    network = "mainnet"
    access_config {
      // Ephemeral IP
    }
  }

  attached_disk {
    source = "factom-main-node-disk-b"
  }

  metadata {
    sshKeys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }
}
