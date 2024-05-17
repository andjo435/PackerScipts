//  BLOCK: packer config





packer {
  required_version = ">= 1.9.4"
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = ">= 1.2.1"
    }



  }
}





//  BLOCK: locals
//  Defines the local variables.



locals {
  iso_paths         = ["[NFS_ISO] Packer/ubuntu-20.04.5-live-server-amd64.iso"]
  ovf_export_path   = "${path.cwd}/artifacts/${local.vm_name}"
  data_source_content = {
    "/ks.cfg" = templatefile("${abspath(path.root)}/data/ks.pkrtpl.hcl", {
      vm_guest_os_language     = "en_US"
      vm_guest_os_keyboard     = "us"
      vm_guest_os_timezone     = "UTC"
    })
  }
  data_source_command = "http" == "http" ? "inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg" : "inst.ks=cdrom:/ks.cfg"
  vm_name             = "pleasework"



}



//  BLOCK: source
//  Defines the builder configuration blocks.



source "vsphere-iso" "linux" {



  // vCenter Server Endpoint Settings and Credentials
  vcenter_server      = "10.168.230.20"
  username            = ""
  password            = ""
  insecure_connection = true



  // vSphere Settings
  datacenter                     = "DC - LABSO"
  cluster                        = "CL-VxR"
  host                           = "vxr-node-03.labso.lu.local"
  datastore                      = "VxRail - vsanDatastore"
  folder                         = "/Andrade Monteiro"   #folder where the machine and template will be deployed
  // resource_pool                  = var.vsphere_resource_pool
  set_host_for_datastore_uploads = false



  // Virtual Machine Settings
  vm_name              = local.vm_name
  guest_os_type        = "ubuntu64Guest"
  firmware             = "efi"
  CPUs                 = 2
  cpu_cores            = 1
  CPU_hot_plug         = false
  RAM                  = 2048
  RAM_hot_plug         = false
  cdrom_type           = "sata"
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size             = 107200
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = "VL193"
    // network_card = var.vm_network_card
  }
  vm_version           = 19
  remove_cdrom         = true
  tools_upgrade_policy = true





  // Removable Media Settings
  iso_paths    = local.iso_paths



  // Boot and Provisioning Settings
  http_ip       = null
  http_port_min = 0
  http_port_max = 0
  boot_order    = "disk,cdrom"
  boot_wait     = "8s"
  boot_command = [
        "<enter>",
        "<wait>",
        "<wait>"
  ]
  ip_wait_timeout   = "20m"
  ip_settle_timeout = "5s"
  shutdown_command  = "shutdown -P now"
  shutdown_timeout  = "15m"



  // Communicator Settings and Credentials
  communicator       = "ssh"
  ssh_username       = "xx"   #replace!
  ssh_password       = "xx"   #replace!
  ssh_port           = 22
  ssh_timeout        = "30m"



  // Template and Content Library Settings
  convert_to_template = true
}



//  BLOCK: build



build {
  sources = ["source.vsphere-iso.linux"]
provisioner "shell-local" {
  inline = [


    # "sudo apt-get install -y tar",
    # "sudo apt install apache2 -y",
    # "sudo apt install mysql-server"
  ]
}
}



voici le packer script pour un linux ubuntu, l'extension doit être .pkr.hcl et il faut configurer manuellement l'adresse ip et installer openssh-server pour que packer puisse se connecter dessus. 
