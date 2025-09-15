output "vm_ip" {
  value = proxmox_vm_qemu.cloudinit-arch.default_ipv4_address
}
