# Desafio-Terraform-Ansible

Este repositório contém a documentação e os arquivos do desafio do Bootcamp DevOps da Atlântico Avanti, que consistiu em automatizar a criação e configuração de máquinas virtuais.

O projeto utiliza:

- Proxmox VE como hypervisor para gerenciamento das VMs;

- Terraform para provisionamento automatizado e consistente das VMs;

- Ansible para configuração e deploy de serviços, garantindo que as máquinas fiquem prontas para uso.


## 📌 Etapa 1 – Criando o Template Arch Linux no Proxmox

Nesta primeira etapa, vamos preparar um **template base** do Arch Linux no Proxmox. Esse template será usado posteriormente pelo Terraform para criar VMs de forma automatizada.

### 🔧 Pré-requisitos

- Um servidor com **Proxmox VE** instalado e acessível.  
- Acesso **root** ao Proxmox.  


### 📥 Script de criação do template

O script [`create-arch-vm.sh`](./scripts/create-arch-template.sh) automatiza o processo de:

1. Download da imagem cloud do Arch Linux.
2. Customização da imagem com `virt-customize` (instalação do `qemu-guest-agent`).
3. Criação de uma VM no Proxmox com as configurações básicas.
4. Importação e resize do disco.
5. Habilitação do **cloud-init** para provisionamento.
6. Conversão da VM em **template** automaticamente.

### ▶️ Como usar

1. Clone o repositório:
   ```bash
   git clone https://github.com/LuisCarlosJp/Desafio-Terraform-Ansible.git
   cd homelab
   ```

2. Dê permissão de execução ao script:
   ```bash
   chmod +x create-arch-vm.sh
   ```

3. Execute o script como **root**:
   ```bash
   ./create-arch-vm.sh
   ```

4. Após a execução, você terá um **template Arch Linux** (`ArchLinux-cloud-init`) criado no Proxmox, pronto para ser usado pelo Terraform.

### ⚙️ Configurações padrão do template

- **VM ID:** 9001  
- **Nome:** ArchLinux-cloud-init  
- **CPU:** 1 core (host)  
- **Memória:** 3 GB  
- **Disco:** 100 GB (expandido a partir da imagem original)  
- **Rede:** VirtIO bridge `vmbr0`  
- **Cloud-init:** habilitado  
