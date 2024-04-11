variable "key_name" {
  type        = string
  default     = ""
  description = "Name keypair"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map()`"
}
  