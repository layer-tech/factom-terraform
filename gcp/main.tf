provider "google" {
  credentials = "${file("account.json")}"
  project     = "factom-node-project"
  region      = "us-central1-a"
}
