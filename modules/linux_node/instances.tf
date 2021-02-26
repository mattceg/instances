resource "google_compute_instance" "my_vm" {
	name = var.name
	machine_type = var.type_of_machine
	zone = var.zone
	boot_disk {
		initialize_params {
                  image = var.boot_disk
                } // close the 'initilize_params' block
        } // close the 'boot_disk' block
// Update all packages on the new VM at launch
metadata_startup_script = var.metadata_startup_script


// Set the network interface on which to launch the VM

  network_interface{

    subnetwork = var.subnetwork
    network = var.network

  access_config { } //This will be used later to identify the IP Address

} // Close the 'network_interface' block
  metadata = {
     ssh-keys = var.ssh-keys
  }
} // Close the entire VM resource
