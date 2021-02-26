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
  metadata = {
     ssh-keys = "mattceg:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDssBOftQTO8ooa1Y8Lc3hoj2Ob15DBayaqXYICXtghPtZGu6RHrBJ4rvnxI1+bo0bJW2nSWdzZbRy3/Sl39PxTKcy5n4H/Y3uFhNrRZEubJXaSyT1gmv86qFuMW+HY/Cmb6tFX+u2IiT+DjLDry9U2bm8P1ROpGfB65tVcZetY8iB5ZfJy68AgmhcmQ20ZlqUv0UDHqeNqHnx5ZPPz8fvk+PeK1SlhDNXX05hZeSuVa5/YgVWaLIpWeQj/cZE/wnrpBWuajhAanNTGBy7KPZFs5FFg7sH3oSXnybUqW5KCQ/52PsXZAQGMhA/BFYM239ZBJ8lJliBVOfkuvCicl1j4aR0Wh0vsRrmPUz9cfp8n2VEdELI7hzeoOIJSDyIWBC3SVur2qCyG8XZPYFoZQfICFiw5A1Knuc32jM1BFVKgw7xmCpHfO2uM2lhSMZu4ZYCEVgAQS3/iflJcduR3YS0/A7e4dGo5UE52s18Hnd1HXTYhjpyOzfg82Gh6AQKDGJc= mattceg@matt-base-vm"
  }
} // Close the entire VM resource
