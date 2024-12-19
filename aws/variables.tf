variable "lab_duration" {
  type = string
  default = "2h"
  validation {
    condition     = can(regex("^[0-9]+[mh]$", var.lab_duration))
    error_message = "lab_duration must be a string of the format '2h' or '1d'"
  }
}