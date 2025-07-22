variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "resource_group_location" {
  type        = string
  description = "The location of the resource group"
}

variable "resource_group_tags" {
  type        = map(string)
  description = "The tags of the resource group"
  default     = {}
}