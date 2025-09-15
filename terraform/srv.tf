resource "proxmox_vm_qemu" "cloudinit-arch" {
  name   = "ArchServer"
  description   = "Archlinux server"
  target_node = "v1"
  
  agent = 1  
   
  clone = "ArchLinux-cloud-init"
  cpu {
      cores = 1
      sockets = 1
  } 

  
  memory = 3072

  network {
      id = 0
      bridge = "vmbr0"
      model = "virtio"
  }
  
  serial {
      id = 0
  }
  
  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "local-lvm"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = "52G" 
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  } 
  os_type = "cloud-init"
  ipconfig0  = "ip=dhcp"
  ciuser = "AnsibleWorker"
  sshkeys = file("${pathexpand("~")}/.ssh/id_rsa.pub") 
}
