#!/bin/bash
# ============================================================
# Script: create-terraform-user-token.sh
# Descrição: Cria usuário, role e API Token para uso com Terraform no Proxmox
# ============================================================

# Configuração
USER="terraform-prov@pve"
ROLE="TerraformProv"
TOKEN_ID="mytoken"   # Nome do token (pode personalizar)

echo "🔧 Criando role '$ROLE' com privilégios necessários..."
pveum role add $ROLE -privs "Datastore.AllocateSpace Datastore.AllocateTemplate Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"

echo "👤 Criando usuário '$USER'..."
pveum user add $USER --comment "Terraform provisioner user"

echo "🔐 Criando token '$TOKEN_ID' para o usuário '$USER'..."
pveum user token add $USER $TOKEN_ID

echo "📌 Atribuindo role '$ROLE' ao usuário '$USER'..."
pveum aclmod / -user $USER -role $ROLE

echo "✅ Usuário, role e token criados com sucesso!"
echo ""
echo "Use as credenciais no Terraform assim:"
echo "PM_USER=$USER!$TOKEN_ID"
echo "PM_TOKEN=<token-secret-retornado>"
