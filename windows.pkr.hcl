
packer {
  required_version = ">= 1.9.4"
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = ">= 1.2.1"
    }

  }
}


locals {
  iso_urls                   = ["https://software-static.download.prss.microsoft.com/sg/download/888969d5-f34g-4e03-ac9d-1f9786c66749/SERVER_EVAL_x64FRE_en-us.iso"]
  vm_name                    = "WIN2022"
  iso_paths                  = ["[NFS_ISO] Windows/Windows Server/en-us_windows_server_2022_x64_dvd_620d7eac.iso"]

}


source "vsphere-iso" "WIN2022_Std" {

  // vCenter Server Endpoint Settings and Credentials
  vcenter_server      = "10.168.230.20"
  username            = "xx"
  password            = "xx"
  insecure_connection = true

  // vSphere Settings
  datacenter                     = "DC - LABSO"
  cluster                        = "CL-VxR"
  host                           = "vxr-node-03.labso.lu.local"
  datastore                      = "VxRail - vsanDatastore"
  folder                         = "/Andrade Monteiro"

  // Virtual Machine Settings
  vm_name              = "Win2022"
  guest_os_type        = "windows2019srvNext_64Guest"
  firmware             = "efi-secure"
  CPUs                 = 2
  cpu_cores            = 1
  CPU_hot_plug         = false
  RAM                  = 4096
  RAM_hot_plug         = false
  cdrom_type           = "sata"
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size             = 102400
    disk_controller_index = 0
    disk_thin_provisioned = true
  }
  network_adapters {
    network      = "VL193"

  }
  vm_version           = "19"
  remove_cdrom         = true
  tools_upgrade_policy = true


  // Removable Media Settings
  iso_paths = local.iso_paths
  cd_files = [
    
    "./scripts/windows-init.ps1",
    

  ]
  cd_content = {
    "autounattend.xml" = templatefile("${abspath(path.root)}/data/autounattend.pkrtpl.hcl", {
      build_username       = "Administrator"
      build_password       = "secretpassword"
      vm_inst_os_language  = "en-US"
      vm_inst_os_keyboard  = "en-GB"
      vm_inst_os_image     = "Windows Server 2022 SERVERSTANDARD"
      vm_inst_os_kms_key   = "VDYBN-27WPP-V4HQT-9VMD4-VMK7H"
      vm_guest_os_language = "en-US"
      vm_guest_os_keyboard = "en-GB"
      vm_guest_os_timezone = "GMT Standard Time"
    })
  }

  // Boot and Provisioning Settings
  http_port_min     = "0"
  http_port_max     = "0"
  boot_order        = "disk,cdrom"
  boot_wait         = "2s"
  boot_command      = ["<spacebar>"]
  ip_wait_timeout   = "20m"
  ip_settle_timeout = "5s"
  shutdown_command  = "shutdown /s /f"
  shutdown_timeout  = "15m"

  // Communicator Settings and Credentials
  communicator   = "winrm"
  winrm_username = "Administrator"
  winrm_password = "secretpassword"
  winrm_port     = 5985
  winrm_timeout  = "12h"

  // Template and Content Library Settings
  convert_to_template = true

}


build {
  sources = [

        "source.vsphere-iso.WIN2022_Std"

  ]



provisioner "powershell" {
        scripts           = [
      "${path.cwd}/scripts/windows-init.ps1",
    ]
  }

}
