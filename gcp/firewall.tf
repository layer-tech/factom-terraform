############################################################################
# Main network Authority Nodes
############################################################################
resource "google_compute_firewall" "firewall-auth-ingress" {
  name    = "factom-firewall-auth-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["8090", "8091", "8108", "8220", "8110"]
  }

  source_tags = ["0.0.0.0/0"]
  target_tags = ["factom-auth-ingress"]
}

resource "google_compute_firewall" "firewall-auth-egress" {
  name    = "factom-firewall-auth-egress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["8090", "8091", "8108", "8220", "8110"]
  }

  destination_ranges = ["0.0.0.0/0"]
  target_tags = ["factom-auth-egress"]

  direction = "EGRESS"
}

resource "google_compute_firewall" "firewall-auth-factomd-port" {
  name    = "factom-firewall-auth-factomd-port"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["8108", "8090"]
  }

  priority = 500

  target_tags = ["factom-auth-ingress"]
  source_ranges = ["0.0.0.0/0"]
}

############################################################################
# Main net SSH
############################################################################
resource "google_compute_firewall" "firewall-main-ssh" {
  name    = "factom-firewall-main-ssh"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["factom-main-ssh"]
  source_ranges = ["${var.admin_range}"]
}

############################################################################
# Docker engine for swarm
############################################################################
resource "google_compute_firewall" "firewall-docker-engine" {
  name = "factom-docker-engine"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports = ["2376", "2222", "8088", "8090", "8108"]
  }

  target_tags = ["docker-engine"]
  source_ranges = ["52.48.130.243"]
}

############################################################################
# Monitoring
############################################################################
resource "google_compute_firewall" "firewall-monitoring-ingress" {
  name    = "factom-firewall-monitoring-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["9090","9093", "3000"]
  }

  target_tags = ["factom-internal-monitoring-ingress"]
  source_ranges = ["${var.admin_range}"]
}

resource "google_compute_firewall" "firewall-monitoring-egress" {
  name    = "factom-firewall-monitoring-egress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["9090", "9093", "3000"]
  }

  target_tags = ["factom-internal-monitoring-egress"]
  destination_ranges = ["${var.admin_range}"]

  direction = "EGRESS"
}

resource "google_compute_firewall" "firewall-grafana-ingress" {
  name    = "factom-firewall-grafana-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  priority = 500

  target_tags = ["factom-internal-monitoring-ingress"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "firewall-jenkins-ingress" {
  name    = "factom-firewall-jenkins-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  priority = 500

  target_tags = ["factom-internal-monitoring-ingress"]
  source_ranges = ["0.0.0.0/0"]
}

############################################################################
# Monitoring Exporters
############################################################################
resource "google_compute_firewall" "firewall-monitoring-export-ingress" {
  name    = "factom-firewall-monitoring-export-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["9090", "9093", "3000", "9100"]
  }

  target_tags = ["factom-internal-monitoring-export-ingress"]
  source_ranges = ["${var.monitoring_range}"]
}

resource "google_compute_firewall" "firewall-monitoring-export-egress" {
  name    = "factom-firewall-monitoring-export-egress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["9090", "9093", "3000", "9100"]
  }

  target_tags = ["factom-internal-monitoring-export-egress"]
  destination_ranges = ["${var.monitoring_range}"]

  direction = "EGRESS"
}

############################################################################
# Swarm Master
############################################################################
resource "google_compute_firewall" "firewall-swarm-ingress" {
  name    = "factom-firewall-swarm-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["2376", "2222", "8090", "8108", "8088"]
  }

  priority = 500

  target_tags = ["factom-internal-swarm-ingress"]
  source_ranges = ["52.48.130.243"]
}

resource "google_compute_firewall" "firewall-swarm-egress" {
  name    = "factom-firewall-swarm-egress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["2376", "2377", "8088", "2222"]
  }

  priority = 500

  target_tags = ["factom-internal-swarm-egress"]
  destination_ranges = ["52.48.130.243"]

  direction = "EGRESS"
}
