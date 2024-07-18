provider "google" {
  credentials = file("key.json")
  project     = "hack-team-neuronurturers"
  region      = "europe-west3"
}

resource "google_storage_bucket" "my_bucket" {
  name     = "hack-team-neuronurturers_tfc_bucket"
  location = "US"
}

resource "google_project_service" "vision_api" {
  project = "hack-team-neuronurturers"
  service = "vision.googleapis.com"
}

resource "google_storage_bucket_iam_binding" "bucket_binding" {
  bucket = google_storage_bucket.my_bucket.name

  role    = "roles/storage.objectViewer"
  members = [
    "serviceAccount:workload@hack-team-neuronurturers.iam.gserviceaccount.com"
  ]
}

resource "google_project_iam_binding" "vision_api_binding" {
  project = "hack-team-neuronurturers"
  role    = "roles/vision.apiUser"

  members = [
    "serviceAccount:workload@hack-team-neuronurturers.iam.gserviceaccount.com"
  ]
}

output "bucket_url" {
  value = google_storage_bucket.my_bucket.url
}
