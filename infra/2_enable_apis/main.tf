# main.tf

provider "google" {
  project = var.project_id
  region  = var.region
}


# Enable Cloud Build API
resource "google_project_service" "cloud_build" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
}

# Enable Artifact Registry API
resource "google_project_service" "artifact_registry" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
}

# Enable Cloud Run API
resource "google_project_service" "cloud_run" {
  project = var.project_id
  service = "run.googleapis.com"
}

# Enable IAM API (for managing permissions)
resource "google_project_service" "iam" {
  project = var.project_id
  service = "iam.googleapis.com"
}

# Enable Cloud Storage API (optional, for storing artifacts)
resource "google_project_service" "cloud_storage" {
  project = var.project_id
  service = "storage.googleapis.com"
}

# Enable Pub/Sub API (optional, if your project needs Pub/Sub)
resource "google_project_service" "pubsub" {
  project = var.project_id
  service = "pubsub.googleapis.com"
}

# Enable Container Registry API (optional, if using Container Registry instead of Artifact Registry)
resource "google_project_service" "container_registry" {
  project = var.project_id
  service = "containerregistry.googleapis.com"
}

# Enable Compute Engine API (if necessary for your infrastructure)
resource "google_project_service" "compute_engine" {
  project = var.project_id
  service = "compute.googleapis.com"
}

# Enable Kubernetes Engine API (optional, if using GKE)
resource "google_project_service" "kubernetes_engine" {
  project = var.project_id
  service = "container.googleapis.com"
}

