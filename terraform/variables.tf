variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "vm_name" {
  type    = string
  default = "ArchServer"
}

variable "vm_description" {
  type    = string
  default = "Archlinux server"
}

variable "vm_target_node" {
  type    = string
  default = "v1"
}

variable "vm_template" {
  type    = string
  default = "ArchLinux-cloud-init"
}

variable "vm_cpu_cores" {
  type    = number
  default = 1
}

variable "vm_cpu_sockets" {
  type    = number
  default = 1
}

variable "vm_memory" {
  type    = number
  default = 3072
}

variable "vm_disk_storage" {
  type    = string
  default = "local-lvm"
}

variable "vm_disk_size" {
  type    = string
  default = "52G"
}

variable "vm_network_bridge" {
  type    = string
  default = "vmbr0"
}

variable "vm_ci_user" {
  type    = string
  default = "AnsibleWorker"
}

variable "vm_ssh_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

