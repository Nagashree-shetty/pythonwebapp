variable "imagetag" {
  type = "string"
  description = "Build tag from azure yml file"
}

variable "imagebuild" {
  description = "Repository"
  default = "nagashreeshetty/newpythonwebapp:${var.imagetag}"
}



