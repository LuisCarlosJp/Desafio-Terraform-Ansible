#!/bin/bash
# ============================================================
# Script: create-terraform-user.sh
# Descrição: Cria usuário e role para o Terraform no Proxmox
# ============================================================

# Configuração
USER="terraform-prov@pve"
PASSWORD="<password>"   # Substitua pela senha desejada
ROLE="TerraformProv"

echo "🔧 Criando role '$ROLE' com privilégios necessários..."
pveum role add $ROLE -privs "Datastore.AllocateSpace Datastore.AllocateTemplate Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"

echo "👤 Criando usuário '$USER'..."
pveum user add $USER --password $PASSWORD

echo "🔐 Atribuindo role '$ROLE' ao usuário '$USER'..."
pveum aclmod / -user $USER -role $ROLE

echo "✅ Usuário e permissões configurados com sucesso!"
