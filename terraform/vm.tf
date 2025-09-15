resource "proxmox_vm_qemu" "cloudinit-arch" {
  name        = var.vm_name
  description = var.vm_description
  target_node = var.vm_target_node

  agent = 1
  clone = var.vm_template

  cpu {
    cores   = var.vm_cpu_cores
    sockets = var.vm_cpu_sockets
  }

  memory = var.vm_memory

  network {
    id     = 0
    bridge = var.vm_network_bridge
    model  = "virtio"
  }

  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage = var.vm_disk_storage
          size    = var.vm_disk_size
        }
      }
    }
    ide {
      ide1 {
        cloudinit {
          storage = var.vm_disk_storage
        }
      }
    }
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=dhcp"

  ciuser  = var.vm_ci_user
  sshkeys = file(pathexpand(var.vm_ssh_key_path))
}

