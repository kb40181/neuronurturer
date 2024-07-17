provider "google" {
  credentials = file("<YOUR_SERVICE_ACCOUNT_KEY_FILE>.json")
  project     = "<YOUR_PROJECT_ID>"
  region      = "<YOUR_DEFAULT_REGION>"
}

resource "google_storage_bucket" "my_bucket" {
  name     = "my-unique-bucket-name"
  location = "US"
}

resource "google_project_service" "vision_api" {
  project = "<YOUR_PROJECT_ID>"
  service = "vision.googleapis.com"
}

resource "google_storage_bucket_iam_binding" "bucket_binding" {
  bucket = google_storage_bucket.my_bucket.name

  role    = "roles/storage.objectViewer"
  members = [
    "serviceAccount:<YOUR_SERVICE_ACCOUNT_EMAIL>"
  ]
}

resource "google_project_iam_binding" "vision_api_binding" {
  project = "<YOUR_PROJECT_ID>"
  role    = "roles/vision.apiUser"

  members = [
    "serviceAccount:<YOUR_SERVICE_ACCOUNT_EMAIL>"
  ]
}

output "bucket_url" {
  value = google_storage_bucket.my_bucket.url
}
