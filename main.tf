resource "google_pubsub_topic" "my_topic" {
  project = var.project_id
  count   = length(var.topic_name)
  name    = var.topic_name[count.index]

}

resource "google_pubsub_subscription" "my_subs" {
  project = var.project_id
  count   = length(var.subs_name)
  name    = var.subs_name[count.index]
  topic   = google_pubsub_topic.my_topic[count.index].name



  # 7 dias
  message_retention_duration = "604800s"
  retain_acked_messages      = true

  ack_deadline_seconds = 600

  expiration_policy {
    ttl = "604800s"
  }

  enable_message_ordering = false
}

# DLQ

resource "google_pubsub_topic" "my_dead_letter" {
  project = var.project_id
  count   = length(var.dlq_name)
  name    = var.dlq_name[count.index]
}

resource "google_pubsub_subscription" "dead_letter_sub" {
  project = var.project_id
  count   = length(var.dlq_name_subs)
  name    = var.dlq_name_subs[count.index]
  topic   = google_pubsub_topic.my_topic[count.index].name
  expiration_policy {
    ttl = ""
  }
  dead_letter_policy {
    dead_letter_topic     = google_pubsub_topic.my_dead_letter[count.index].id
    max_delivery_attempts = 10
  }
}