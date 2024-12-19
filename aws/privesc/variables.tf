variable "tags" {
  type = map(string)
}

variable "target_lab" {
  type = string
}

variable "time" {
  type = object({
    now = string
    end = string
  })
}