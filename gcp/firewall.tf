resource "google_compute_firewall" "firewall-guard-ingress" {
  name    = "factom-firewall-guard-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["8090", "8091", "8110", "8220", "8110"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["factom-guard-ingress"]
}

resource "google_compute_firewall" "firewall-guard-egress" {
  name    = "factom-firewall-guard-egress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["8090", "8091", "8110", "8220", "8110"]
  }

  target_tags = ["factom-guard-egress"]

  direction = "EGRESS"
}

resource "google_compute_firewall" "firewall-auth-deny" {
  name   = "factom-firewall-auth-ingress-deny"
  network = "mainnet"

  deny {
    protocol = "all"
  }

  priority = 2000

  source_tags = ["factom-auth-ingress"]
}

resource "google_compute_firewall" "firewall-auth-deny-egress" {
  name   = "factom-firewall-auth-egress-deny"
  network = "mainnet"

  deny {
    protocol = "all"
  }

  priority = 2000

  source_tags = ["factom-auth-ingress"]

  direction = "EGRESS"
}

resource "google_compute_firewall" "firewall-auth-ingress" {
  name    = "factom-firewall-auth-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["8090", "8091", "8110", "8220", "8110"]
  }

  source_tags = ["factom-guard-ingress"]
  target_tags = ["factom-auth-ingress"]
}

resource "google_compute_firewall" "firewall-auth-egress" {
  name    = "factom-firewall-auth-egress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["8090", "8091", "8110", "8220", "8110"]
  }

  destination_ranges = ["10.0.0.0/32"]

  target_tags = ["factom-auth-egress"]

  direction = "EGRESS"
}

resource "google_compute_firewall" "firewall-main-ssh" {
  name    = "factom-firewall-main-ssh"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["factom-main-ssh"]
  source_ranges = ["${var.ssh_range}"]
}

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

resource "google_compute_firewall" "firewall-monitoring-ingress" {
  name    = "factom-firewall-monitoring-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["9090","9093", "3000"]
  }

  target_tags = ["factom-internal-monitoring-ingress"]
  source_ranges = ["172.103.22.75"]
}

resource "google_compute_firewall" "firewall-monitoring-egress" {
  name    = "factom-firewall-monitoring-egress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["9090", "9093", "3000"]
  }

  target_tags = ["factom-internal-monitoring-egress"]
  destination_ranges = ["172.103.22.75"]

  direction = "EGRESS"
}

resource "google_compute_firewall" "firewall-monitoring-export-ingress" {
  name    = "factom-firewall-monitoring-export-ingress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["9090", "9093", "3000", "9100"]
  }

  target_tags = ["factom-internal-monitoring-export-ingress"]
  source_ranges = ["10.128.0.4"]
}

resource "google_compute_firewall" "firewall-monitoring-export-egress" {
  name    = "factom-firewall-monitoring-export-egress"
  network = "mainnet"

  allow {
    protocol = "tcp"
    ports    = ["9090", "9093", "3000", "9100"]
  }

  target_tags = ["factom-internal-monitoring-export-egress"]
  destination_ranges = ["10.128.0.4"]

  direction = "EGRESS"
}
