data "terraform_remote_state" "network_details" {
  backend = "gcs"
  config = {
    bucket = "matt-03-bucket01"
    prefix = "matt-03-network-statefile"
  }
}

module "my-server" {
  source = "./modules/linux_node"
  boot_disk = "ubuntu-2004-focal-v20210211"
  name = "matt-03-terraform-vm-test"
  zone = "us-central1-a"
  metadata_startup_script = "sudo apt-get upgrade -y"
  subnetwork = data.terraform_remote_state.network_details.outputs.matts-subnet
  network = data.terraform_remote_state.network_details.outputs.matts-vpc
  ssh-keys = "mattceg:${file("/home/mattceg/terraform_base/keys/matt-03.vmkey.pub")}"
}
