provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_project" "my_project" {
  name       = var.project_name
  project_id = var.project_id
  org_id     = var.organization_id
  billing_account = var.billing_account
}

resource "google_compute_network" "my_custom_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks  = false
  routing_mode             = "REGIONAL"
}

resource "google_compute_subnetwork" "my_custom_subnet" {
  name                     = var.subnet_name
  ip_cidr_range            = var.subnet_range
  region                   = var.region
  network                  = google_compute_network.my_custom_vpc.id
}

variable "project_id" {}
variable "project_name" {}
variable "organization_id" {}
variable "billing_account" {}
variable "vpc_name" { default = "custom-vpc" }
variable "subnet_name" { default = "custom-subnet" }
variable "subnet_range" { default = "10.0.0.0/24" }
variable "region" { default = "us-central1" }
variable "zone" { default = "us-central1-a" }
