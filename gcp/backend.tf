terraform {
  backend "gcs" {
    bucket  = "factom-backend"
    prefix  = "terraform/state"
    credentials = "account.json"
  }
}
