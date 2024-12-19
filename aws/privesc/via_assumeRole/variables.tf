variable "tags" {
  type = map(string)
}

variable "time" {
  type = object({
    now = string
    end = string
  })
}