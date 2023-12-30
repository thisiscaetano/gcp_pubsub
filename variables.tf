variable "project_id" {
  default = "my_project"
}
variable "topic_name" {
  type    = list(string)
  default = ["name", "name1", "name2"]
}
variable "subs_name" {
  type    = list(string)
  default = ["name-sub", "name-sub1", "name-sub2"]
}
variable "dlq_name" {
  type    = list(string)
  default = ["name-dlq", "name-dlq1", "name-dlq2"]
}
variable "dlq_name_subs" {
  type    = list(string)
  default = ["name-dlq-sub", "name-dlq-sub1", "name-dlq-sub2"]
}