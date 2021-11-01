variable "region" {
  default = "us-east-1"
}

#maybe use object?
variable "requried_tags" {
  type    = map(string)
  description = "Required tags"
  
}