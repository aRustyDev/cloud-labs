variable "lab_category" {
  type = string
}

variable "lab_name" {
  type = string
}

variable "flag_policy_arn" {
  type = string
}

variable "tags" {
  type = object({
    lab_id = string
  })
}