data "google_storage_transfer_project_service_account" "project_service_account" {
  project = var.config.gcp_project_id
}

resource "google_storage_bucket_iam_member" "storage_bucket_iam_member_source" {
  bucket = var.config.gcs_bucket_source
  role   = "roles/storage.admin"
  member = "serviceAccount:${data.google_storage_transfer_project_service_account.project_service_account.email}"
}

resource "google_storage_bucket_iam_member" "storage_bucket_iam_member_destination" {
  bucket = var.config.gcs_bucket_destination
  role   = "roles/storage.admin"
  member = "serviceAccount:${data.google_storage_transfer_project_service_account.project_service_account.email}"
}



resource "google_storage_transfer_job" "transfer_job" {
  description = "My Transfer Job for GCS to GCS,"
  project     = var.config.gcp_project_id
  status      = "ENABLED"

  transfer_spec {
    gcs_data_source {
      bucket_name = var.config.gcs_bucket_source
    }

    gcs_data_sink {
      bucket_name = var.config.gcs_bucket_destination
    }

    transfer_options {
      delete_objects_from_source_after_transfer  = false
      overwrite_objects_already_existing_in_sink = true
    }
  }

  schedule {
    schedule_start_date {
      year  = 2025
      month = 1
      day   = 30
    }
    schedule_end_date {
      year  = 2025
      month = 12
      day   = 31
    }
    start_time_of_day {
      hours   = 0
      minutes = 5
      seconds = 0
      nanos   = 0
    }
  }
  depends_on = [google_storage_bucket_iam_member.storage_bucket_iam_member_destination, google_storage_bucket_iam_member.storage_bucket_iam_member_source]
}
