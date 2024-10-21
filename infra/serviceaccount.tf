# Set up provider for Google Cloud
provider "google" {
  project = var.project_id  # Set your GCP project ID as a variable
  region  = "us-central1"   # Set your preferred region
}

# Create a new service account
resource "google_service_account" "ci_service_account" {
  account_id   = "ci-service-account"  # Customize the name of your service account
  display_name = "CI Service Account for Cloud Build and Cloud Run"
}

# Assign roles to the CI Service Account (e.g., Cloud Run Admin, Artifact Registry Writer, etc.)
resource "google_project_iam_member" "ci_run_admin" {
  project = var.project_id
  role    = "roles/run.admin"  # Cloud Run Admin role
  member  = "serviceAccount:${google_service_account.ci_service_account.email}"
}

resource "google_project_iam_member" "ci_artifact_registry_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"  # Artifact Registry Writer role
  member  = "serviceAccount:${google_service_account.ci_service_account.email}"
}

resource "google_project_iam_member" "ci_logging_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"  # Logging writer role
  member  = "serviceAccount:${google_service_account.ci_service_account.email}"
}

# Give Cloud Build service account the permission to impersonate the CI service account
resource "google_service_account_iam_binding" "allow_cloudbuild_impersonation" {
  service_account_id = google_service_account.ci_service_account.name

  role = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${var.cloud_build_sa_email}"  # Cloud Build service account email from var
  ]
}

# Optionally, allow the CI service account to impersonate itself (for more complex workflows)
resource "google_service_account_iam_binding" "allow_self_impersonation" {
  service_account_id = google_service_account.ci_service_account.name

  role = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:${google_service_account.ci_service_account.email}"  # CI service account itself
  ]
}

# IAM binding for other service accounts (example: grant another service account access)
resource "google_service_account_iam_binding" "other_sa_iam_binding" {
  service_account_id = google_service_account.ci_service_account.name

  role = "roles/iam.serviceAccountUser"

  members = [
    "serviceAccount:other-service-account@${var.project_id}.iam.gserviceaccount.com"  # Example other service account
  ]
}

# Variables
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "cloud_build_sa_email" {
  description = "Email of the Cloud Build service account"
  type        = string
}
