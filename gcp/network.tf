# Networking
resource "google_compute_network" "mainnet" {
  name                    = "mainnet"
  description = "Network for nodes on the main net"
}
