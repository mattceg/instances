data "terraform_remote_state" "network_details" {
  backend = "gcs"
  config = {
    bucket = "matt-03-bucket01"
    prefix = "matt-03-network-statefile"
  }
}

resource "google_compute_instance" "my_vm" {
	name = "matt-03-terraform-vm-test"
	machine_type = "e2-micro"
	zone = "us-central1-a"
	boot_disk {
		initialize_params {
                  image = "ubuntu-2004-focal-v20210211"
                } // close the 'initilize_params' block
        } // close the 'boot_disk' block
// Update all packages on the new VM at launch
metadata_startup_script = "sudo apt-get update -y && sudo apt-get upgrade -y"


// Set the network interface on which to launch the VM

  network_interface{

    subnetwork = data.terraform_remote_state.network_details.outputs.matts-subnet
    network = data.terraform_remote_state.network_details.outputs.matts-vpc

  access_config { } //This will be used later to identify the IP Address

} // Close the 'network_interface' block
} // Close the entire VM resource
