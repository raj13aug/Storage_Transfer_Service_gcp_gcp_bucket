variable "config" {
  type = object({
    gcp_project_id         = string
    gcs_bucket_source      = string
    gcs_bucket_destination = string
    region                 = string
    location               = string
  })
  default = {
    gcp_project_id         = "vm-group-448915"
    gcs_bucket_source      = "cloudroot7_7777"
    gcs_bucket_destination = "cloudroot7_8888"
    region                 = "us-east-1"
    location               = "us"
  }
}