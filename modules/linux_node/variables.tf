variable "type_of_machine" {
   default = "e2-micro"
}
variable "boot_disk" {}

variable "name" {}

variable "zone" {
   default = "us-central1-a"
}
variable metadata_startup_script {}

variable "subnetwork" {}

variable "network" {}

variable "ssh-keys" {}
