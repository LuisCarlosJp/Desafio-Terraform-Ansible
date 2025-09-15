#!/bin/bash
set -e

# Variáveis
VMID=9001
VMNAME="ArchLinux-cloud-init"
IMG="Arch-Linux-x86_64-cloudimg.qcow2"
IMG_URL="https://geo.mirror.pkgbuild.com/images/latest/${IMG}"
STORAGE="local-lvm"

# Instalar dependências
apt update && apt install -y libguestfs-tools wget

# Baixar imagem
if [ ! -f "$IMG" ]; then
    echo "Baixando imagem do Arch Linux..."
    wget -O "$IMG" "$IMG_URL"
fi

# Customizar imagem com qemu-guest-agent
virt-customize \
  --add "$IMG" \
  --run-command 'pacman-key --init' \
  --run-command 'pacman-key --populate archlinux' \
  --run-command 'pacman -Sy --noconfirm' \
  --install qemu-guest-agent

# Criar VM
qm create $VMID \
 --name $VMNAME \
 --numa 0 \
 --ostype l26 \
 --cpu host \
 --cores 1 \
 --sockets 1 \
 --memory 3072 \
 --net0 virtio,bridge=vmbr0

# Importar disco
qm importdisk $VMID "$IMG" $STORAGE

# Configurar VM
qm set $VMID --scsihw virtio-scsi-pci --scsi0 ${STORAGE}:vm-$VMID-disk-0
qm set $VMID --ide2 ${STORAGE}:cloudinit
qm set $VMID --boot c --bootdisk scsi0
qm set $VMID --serial0 socket --vga serial0
qm set $VMID --agent enabled=1

# Redimensionar disco
qm disk resize $VMID scsi0 +50G

qm template $VMID

echo "✅ VM $VMNAME (ID: $VMID) criada com sucesso!"
