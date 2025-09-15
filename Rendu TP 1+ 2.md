# TP1
## I. Prérequis
### 2. Une paire de clés SSH
Déterminer quel algorithme de chiffrement utiliser pour vos clés :

**Lequel :**
ECDSA

**Pourquoi pas RSA :**
https://www.silicon.fr/Thematique/cybersecurite-1371/Breves/Chiffrement-faut-il-mettre-RSA-en-veilleuse--446780.htm

**Pourquoi ECDSA :**
https://cyber.gouv.fr/publications/usage-securise-dopenssh
```
Page 9 :
"Lorsque les clients et les serveurs SSH supportent ECDSA, son usage doit être préféré à RSA."
```

Générer une paire de clés pour ce TP :
```shell
#comande:
ssh-keygen -t ecdsa -b 256 -f ./.ssh/cloud_tp1

#résultat:
Generating public/private ecdsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in ./.ssh/cloud_tp1
Your public key has been saved in ./.ssh/cloud_tp1.pub
The key fingerprint is:
SHA256:iLqh+KSFxZV1uGLfX48c4iIzscYKtmnkfzVeJQAD+U4 jacques@DESKTOP-HQPG8AH
The key's randomart image is:
+---[ECDSA 256]---+
|    .o+o.        |
|    .o.o.        |
|    o. . .       |
| . .o.E.  . .    |
|  o..=..S  o     |
| o..  + + o o    |
|.oB  . = = + +   |
|.*o*  O o o o .  |
|+o=.o+ + .       |
+----[SHA256]-----+
```


Configurer un agent SSH sur votre poste :
```powershell
#commande: 
PS C:\WINDOWS\system32> Add-WindowsCapability -Online -Name OpenSSH.Client

#résultat:
>>


Path          :
Online        : True
RestartNeeded : False

```
```powershell
#commande:
Set-Service ssh-agent -StartupType 'Automatic'
>> Start-Service ssh-agent
```

```shell
#commande :
ssh-add "C:\Users\Jacques\.ssh\cloud_tp1"

#résultat :
Enter passphrase for C:\Users\Jacques\.ssh\cloud_tp1:
Identity added: C:\Users\Jacques\.ssh\cloud_tp1 (jacques@DESKTOP-HQPG8AH)
```

Je rajoute la commande ci-dessous car j'ai du utilisé cette clé pour la VM par az car le format de la clé que j'ai générée n'est pas acceptée par Azure
```shell
#commande :
ssh-add "C:\Users\Jacques\.ssh\id_25519"

#résultat :
Identity added: C:\Users\Jacques\.ssh\id_ed25519 (jacques@DESKTOP-HQPG8AH)
```
## II. Spawn des VMs
### 1. Depuis la WebUI
Connection en SSH à la VM pour preuve:
```shell
#comande:
ssh azureuser@20.162.213.136

#résultat:
Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.11.0-1018-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Fri Sep  5 10:40:37 UTC 2025

  System load:  0.0               Processes:             112
  Usage of /:   5.7% of 28.02GB   Users logged in:       0
  Memory usage: 32%               IPv4 address for eth0: 172.16.0.4
  Swap usage:   0%


Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

Last login: Fri Sep  5 07:48:00 2025 from 216.252.179.121
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

azureuser@VM-1:~$
```
### 2. az : a programmatic approach
Création de VM depuis le Azure CLI :
```powershell
#commande :
PS C:\Users\Jacques> az login

#résultat:
Select the account you want to log in with. For more information on login with Azure CLI, see https://go.microsoft.com/fwlink/?linkid=2271136

Retrieving tenants and subscriptions for the selection...

[Tenant and subscription selection]

No     Subscription name    Subscription ID                       Tenant
-----  -------------------  ------------------------------------  --------
[1] *  Azure for Students   ************************************  Efrei

The default is marked with an *; the default tenant is 'Efrei' and subscription is 'Azure for Students' (************************************).

Select a subscription and tenant (Type a number or Enter for no changes): 1

Tenant: Efrei
Subscription: Azure for Students (************************************)

[Announcements]
With the new Azure CLI login experience, you can select the subscription you want to use more easily. Learn more about it and its configuration at https://go.microsoft.com/fwlink/?linkid=2271236

If you encounter any problem, please open an issue at https://aka.ms/azclibug

[Warning] The login output has been updated. Please be aware that it no longer displays the full list of available subscriptions by default.

PS C:\Users\Jacques>
```
```powershell
#commande :
az vm create `
  --resource-group GP-JAcques `
  --name VM2 `
  --image Ubuntu2204 `
  --size Standard_B1s `
  --admin-username azureuser `
  --ssh-key-values C:\Users\Jacques\.ssh\id_ed25519.pub # je n'utilise pas la clé que je viens de générer car elle refusée par azure malgré sa recommandation par l'ANSI, j'utilise donc la clé utilisée pour la VM créée en WebUI

#résultat :
The default value of '--size' will be changed to 'Standard_D2s_v5' from 'Standard_DS1_v2' in a future release.
{
  "fqdns": "",
  "id": "/subscriptions/************************************/resourceGroups/GP-JAcques/providers/Microsoft.Compute/virtualMachines/VM2",
  "location": "uksouth",
  "macAddress": "7C-1E-52-1D-3C-66",
  "powerState": "VM running",
  "privateIpAddress": "172.16.0.5",
PS C:\Users\Jacques>
```
Connexion SSH via IP publique :
```shell
#commande :
ssh azureuser@172.166.164.86

#résultat :
The authenticity of host '172.166.164.86 (172.166.164.86)' can't be established.
ED25519 key fingerprint is SHA256:QhKGySy1M5HRjV9AK91a6e2RlQKIzl9DuJFGmIVqn5I.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '172.166.164.86' (ED25519) to the list of known hosts.
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1031-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Fri Sep  5 10:47:19 UTC 2025

  System load:  0.0               Processes:             105
  Usage of /:   5.4% of 28.89GB   Users logged in:       0
  Memory usage: 31%               IPv4 address for eth0: 172.16.0.5
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
```
Vérification des services :
```shell
#commande:
azureuser@VM2:~$ systemctl status walinuxagent.service

#résultat:
Warning: The unit file, source configuration file or drop-ins of walinuxagent.service changed on disk. Run 'systemctl d>
● walinuxagent.service - Azure Linux Agent
     Loaded: loaded (/lib/systemd/system/walinuxagent.service; enabled; vendor preset: enabled)
    Drop-In: /run/systemd/system.control/walinuxagent.service.d
             └─50-CPUAccounting.conf, 50-MemoryAccounting.conf
     Active: active (running) since Fri 2025-09-05 10:27:11 UTC; 23min ago
   Main PID: 732 (python3)
      Tasks: 7 (limit: 1008)
     Memory: 45.7M
        CPU: 2.595s
     CGroup: /system.slice/walinuxagent.service
             ├─ 732 /usr/bin/python3 -u /usr/sbin/waagent -daemon
             └─1091 python3 -u bin/WALinuxAgent-2.14.0.1-py3.12.egg -run-exthandlers

Sep 05 10:27:21 VM2 python3[1091]:        8     1000 ACCEPT     tcp  --  *      *       0.0.0.0/0            168.63.129>
Sep 05 10:27:21 VM2 python3[1091]:        0        0 DROP       tcp  --  *      *       0.0.0.0/0            168.63.129>
Sep 05 10:27:21 VM2 python3[1091]: 2025-09-05T10:27:21.764577Z INFO ExtHandler ExtHandler Looking for existing remote a>
Sep 05 10:27:21 VM2 python3[1091]: 2025-09-05T10:27:21.766442Z INFO ExtHandler ExtHandler [HEARTBEAT] Agent WALinuxAgen>
Sep 05 10:32:21 VM2 python3[1091]: 2025-09-05T10:32:21.725474Z INFO CollectLogsHandler ExtHandler WireServer endpoint 1>
Sep 05 10:32:21 VM2 python3[1091]: 2025-09-05T10:32:21.725607Z INFO CollectLogsHandler ExtHandler Wire server endpoint:>
Sep 05 10:32:21 VM2 python3[1091]: 2025-09-05T10:32:21.725689Z INFO CollectLogsHandler ExtHandler Starting log collecti>
Sep 05 10:32:32 VM2 python3[1091]: 2025-09-05T10:32:32.432294Z INFO CollectLogsHandler ExtHandler Successfully collecte>
Sep 05 10:32:32 VM2 python3[1091]: 2025-09-05T10:32:32.444668Z INFO CollectLogsHandler ExtHandler Successfully uploaded>
Sep 05 10:42:20 VM2 python3[732]: 2025-09-05T10:42:20.520403Z INFO Daemon Agent WALinuxAgent-2.14.0.1 launched with com>
lines 1-24/24 (END)
```

```shell
#commande
systemctl status cloud-init.service
#résultat
● cloud-init.service - Cloud-init: Network Stage
     Loaded: loaded (/lib/systemd/system/cloud-init.service; enabled; vendor preset: enabled)
     Active: active (exited) since Fri 2025-09-05 10:27:11 UTC; 55min ago
   Main PID: 483 (code=exited, status=0/SUCCESS)
        CPU: 1.341s

Sep 05 10:27:11 VM2 cloud-init[487]: |. *+BoBooo   .   |
Sep 05 10:27:11 VM2 cloud-init[487]: | .++oo+=+ . o    |
Sep 05 10:27:11 VM2 cloud-init[487]: |  ooo+o+o. +     |
Sep 05 10:27:11 VM2 cloud-init[487]: | . o oo.S.+      |
Sep 05 10:27:11 VM2 cloud-init[487]: |  E o .. . .     |
Sep 05 10:27:11 VM2 cloud-init[487]: |   .      .      |
Sep 05 10:27:11 VM2 cloud-init[487]: |                 |
Sep 05 10:27:11 VM2 cloud-init[487]: |                 |
Sep 05 10:27:11 VM2 cloud-init[487]: +----[SHA256]-----+
Sep 05 10:27:11 VM2 systemd[1]: Finished Cloud-init: Network Stage.
```

### 3. Terraforming ~~planets~~ infrastructures ###

Initialisation Terraform
```tf
#commande :
terraform init

#résultat :
Initializing the backend...
Initializing provider plugins...
- Finding latest version of hashicorp/azurerm...
- Installing hashicorp/azurerm v4.43.0...
- Installed hashicorp/azurerm v4.43.0 (signed by HashiCorp)
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
Terraform plan
```tf
#commande :
terraform plan

#résultat :
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_linux_virtual_machine.main will be created
  + resource "azurerm_linux_virtual_machine" "main" {
      + admin_username                                         = "azureuser"
      + allow_extension_operations                             = (known after apply)
      + bypass_platform_safety_checks_on_user_schedule_enabled = false
      + computer_name                                          = (known after apply)
      + disable_password_authentication                        = (known after apply)
      + disk_controller_type                                   = (known after apply)
      + extensions_time_budget                                 = "PT1H30M"
      + id                                                     = (known after apply)
      + location                                               = "uksouth"
      + max_bid_price                                          = -1
      + name                                                   = "VM-Jack"
      + network_interface_ids                                  = (known after apply)
      + os_managed_disk_id                                     = (known after apply)
      + patch_assessment_mode                                  = (known after apply)
      + patch_mode                                             = (known after apply)
      + platform_fault_domain                                  = -1
      + priority                                               = "Regular"
      + private_ip_address                                     = (known after apply)
      + private_ip_addresses                                   = (known after apply)
      + provision_vm_agent                                     = (known after apply)
      + public_ip_address                                      = (known after apply)
      + public_ip_addresses                                    = (known after apply)
      + resource_group_name                                    = "GP-Jacques"
      + size                                                   = "Standard_B1s"
      + virtual_machine_id                                     = (known after apply)
      + vm_agent_platform_updates_enabled                      = (known after apply)

      + admin_ssh_key {
          + public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINCaieQ8JYg+IZxMWIhUd7k1KxGtfGMWBewDhqgzBft1 jacques@DESKTOP-HQPG8AH"
          + username   = "azureuser"
        }

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + id                        = (known after apply)
          + name                      = "vm-os-disk"
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "0001-com-ubuntu-server-focal"
          + publisher = "Canonical"
          + sku       = "20_04-lts"
          + version   = "latest"
        }

      + termination_notification (known after apply)
    }

  # azurerm_network_interface.main will be created
  + resource "azurerm_network_interface" "main" {
      + accelerated_networking_enabled = false
      + applied_dns_servers            = (known after apply)
      + id                             = (known after apply)
      + internal_domain_name_suffix    = (known after apply)
      + ip_forwarding_enabled          = false
      + location                       = "uksouth"
      + mac_address                    = (known after apply)
      + name                           = "vm-nic"
      + private_ip_address             = (known after apply)
      + private_ip_addresses           = (known after apply)
      + resource_group_name            = "GP-Jacques"
      + virtual_machine_id             = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "internal"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # azurerm_network_interface_security_group_association.main will be created
  + resource "azurerm_network_interface_security_group_association" "main" {
      + id                        = (known after apply)
      + network_interface_id      = (known after apply)
      + network_security_group_id = (known after apply)
    }

  # azurerm_network_security_group.main will be created
  + resource "azurerm_network_security_group" "main" {
      + id                  = (known after apply)
      + location            = "uksouth"
      + name                = "VM-nsg"
      + resource_group_name = "GP-Jacques"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "Allow_SSH"
              + priority                                   = 1001
              + protocol                                   = "Tcp"
              + source_address_prefix                      = "*"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
                # (1 unchanged attribute hidden)
            },
        ]
    }

  # azurerm_public_ip.main will be created
  + resource "azurerm_public_ip" "main" {
      + allocation_method       = "Static"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "uksouth"
      + name                    = "vm-ip"
      + resource_group_name     = "GP-Jacques"
      + sku                     = "Standard"
      + sku_tier                = "Regional"
    }

  # azurerm_resource_group.main will be created
  + resource "azurerm_resource_group" "main" {
      + id       = (known after apply)
      + location = "uksouth"
      + name     = "GP-Jacques"
    }

  # azurerm_subnet.main will be created
  + resource "azurerm_subnet" "main" {
      + address_prefixes                              = [
          + "10.0.1.0/24",
        ]
      + default_outbound_access_enabled               = true
      + id                                            = (known after apply)
      + name                                          = "vm-subnet"
      + private_endpoint_network_policies             = "Disabled"
      + private_link_service_network_policies_enabled = true
      + resource_group_name                           = "GP-Jacques"
      + virtual_network_name                          = "vm-vnet"
    }

  # azurerm_virtual_network.main will be created
  + resource "azurerm_virtual_network" "main" {
      + address_space                  = [
          + "10.0.0.0/16",
        ]
      + dns_servers                    = (known after apply)
      + guid                           = (known after apply)
      + id                             = (known after apply)
      + location                       = "uksouth"
      + name                           = "vm-vnet"
      + private_endpoint_vnet_policies = "Disabled"
      + resource_group_name            = "GP-Jacques"
      + subnet                         = (known after apply)
    }

Plan: 8 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.  
```

Déloiement

```tf
#commande :
terraform apply

#résultat :
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.
```

Connexion SSH

```shell
#commande :
ssh azureuser@172.166.222.224

#résultat :
The authenticity of host '172.166.222.224 (172.166.222.224)' can't be established.
ED25519 key fingerprint is SHA256:K2rpXc0FrbPip8IYUaBgvZL+uRtuETdx2mxSa8AaB7Y.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '172.166.222.224' (ED25519) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Fri Sep  5 14:46:24 UTC 2025

  System load:  0.0               Processes:             110
  Usage of /:   5.3% of 28.89GB   Users logged in:       0
  Memory usage: 30%               IPv4 address for eth0: 10.0.1.4
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

azureuser@VM-Jack:~$
```


# TP2 # 
## I. Network Security Group ##
L'ajout du NSG a été effectué dans le déploiement terraform du TP 1 car je n'avais pas vu qu'il était autorisé d'ouvrir le SSH depuis le WebUI
### 2. Ajouter un NSG au déploiement ###
NSG
```tf
resource "azurerm_network_security_group" "main" {
   name                = "VM-nsg"
   location            = azurerm_resource_group.main.location
   resource_group_name = azurerm_resource_group.main.name

   security_rule {
     name                       = "Allow_SSH"
     priority                   = 1001
     direction                  = "Inbound"
     access                     = "Allow"
     protocol                   = "Tcp"
     source_port_range          = "*"
     destination_port_range     = "22"
     source_address_prefix      = var.ippublic
     destination_address_prefix = "*"
   }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}
```
### 3. Proofs ! ###

Terraform Apply
```tf
#commande :
terraform apply

#résultat :
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

```
Commande AZ

```powershell
#commande :
az network nic show --ids $(az vm show -g GP-Jacques -n VM-Jack --query "networkProfile.networkInterfaces[0].id" -o tsv) -o json

#résultat :
{
  "auxiliaryMode": "None",
  "auxiliarySku": "None",
  "disableTcpStateTracking": false,
  "dnsSettings": {
    "appliedDnsServers": [],
    "dnsServers": [],
    "internalDomainNameSuffix": "wdltdfzsjf0exbsdhantbuywse.zx.internal.cloudapp.net"
  },
  "enableAcceleratedNetworking": false,
  "enableIPForwarding": false,
  "etag": "W/\"e2101332-ab2a-4ef1-b528-80850aa4fc2b\"",
  "hostedWorkloads": [],
  "id": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Network/networkInterfaces/vm-nic",
  "ipConfigurations": [
    {
      "etag": "W/\"e2101332-ab2a-4ef1-b528-80850aa4fc2b\"",
      "id": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Network/networkInterfaces/vm-nic/ipConfigurations/internal",
      "name": "internal",
      "primary": true,
      "privateIPAddress": "10.0.1.4",
      "privateIPAddressVersion": "IPv4",
      "privateIPAllocationMethod": "Dynamic",
      "provisioningState": "Succeeded",
      "publicIPAddress": {
        "id": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Network/publicIPAddresses/vm-ip",        
        "resourceGroup": "GP-Jacques"
      },
      "resourceGroup": "GP-Jacques",
      "subnet": {
        "id": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet",
        "resourceGroup": "GP-Jacques"
      },
      "type": "Microsoft.Network/networkInterfaces/ipConfigurations"
    }
  ],
  "location": "uksouth",
  "macAddress": "7C-1E-52-65-A3-12",
  "name": "vm-nic",
  "networkSecurityGroup": {
    "id": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Network/networkSecurityGroups/VM-nsg",       
    "resourceGroup": "GP-Jacques"
  },
  "nicType": "Standard",
  "primary": true,
  "provisioningState": "Succeeded",
  "resourceGroup": "GP-Jacques",
  "resourceGuid": "01303deb-f314-4e7a-b72c-8c321f3e3c63",
  "tags": {},
  "tapConfigurations": [],
  "type": "Microsoft.Network/networkInterfaces",
  "virtualMachine": {
    "id": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Compute/virtualMachines/VM-Jack",
    "resourceGroup": "GP-Jacques"
  },
  "vnetEncryptionSupported": false
}
```

Connexion SSH (pas de  nom de domaine pour le moment, l'ordre des exercices du TP2 avait été inversé)
```shell
#commande :
 ssh azureuser@172.166.106.70

#résultat :
The authenticity of host '172.166.106.70 (172.166.106.70)' can't be established.
ED25519 key fingerprint is SHA256:PxhvOANpmzdfOW+0b3jwZM9cleiPZTWuNhIFKfM7Obo.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '172.166.106.70' (ED25519) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Fri Sep  5 19:53:50 UTC 2025

  System load:  0.08              Processes:             110
  Usage of /:   5.3% of 28.89GB   Users logged in:       0
  Memory usage: 29%               IPv4 address for eth0: 10.0.1.4
  Swap usage:   0%

 * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
   just raised the bar for easy, resilient and secure K8s cluster deployment.

   https://ubuntu.com/engage/secure-kubernetes-at-the-edge

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

azureuser@VM-Jack:~$
```

SS + SSH refusé
```shell
#commande :
azureuser@VM-Jack:~$ sudo ss -tulpn | grep sshd

#résultat :
tcp     LISTEN   0        128              0.0.0.0:2222          0.0.0.0:*       users:(("sshd",pid=1938,fd=3))         
tcp     LISTEN   0        128                 [::]:2222             [::]:*       users:(("sshd",pid=1938,fd=4)) 
```
```shell
#commande :
ssh -p 2222 azureuser@172.166.106.70
#résultat :
ssh: connect to host 172.166.106.70 port 2222: Connection timed out
```
## II. Un ptit nom DNS ##
### 1. Adapter le plan Terraform ###

Extrait azurerm_public_ip
```tf
resource "azurerm_public_ip" "main" {
  name                = "vm-ip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "vm-jack"
}
```

### 2. Ajouter un output custom à terraform apply ###

Extrait du outputs.tf

```tf
output "vm_public_ip" {
  description = "Adresse IP publique de la VM"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_dns_name" {
  description = "Nom DNS associé à la VM"
  value       = azurerm_public_ip.main.fqdn
}
```
### 3. Proooofs ! ###

Résultat du outputs.tf
```tf
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

vm_dns_name = "vm-jack.uksouth.cloudapp.azure.com"
vm_public_ip = "172.166.161.2"
```

Connexion SSH
```shell
#commande :
ssh azureuser@vm-jack.uksouth.cloudapp.azure.com

#résultat :
The authenticity of host 'vm-jack.uksouth.cloudapp.azure.com (172.166.161.2)' can't be established.
ED25519 key fingerprint is SHA256:O5f5mtSXz+iEP6z2aWm9VIFVc5FdWF8oGj4QKN3IC6g.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'vm-jack.uksouth.cloudapp.azure.com' (ED25519) to the list of known hosts.
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Sat Sep  6 08:47:22 UTC 2025

  System load:  0.55              Processes:             118
  Usage of /:   5.4% of 28.89GB   Users logged in:       0
  Memory usage: 31%               IPv4 address for eth0: 10.0.1.4
  Swap usage:   0%

Expanded Security Maintenance for Applications is not enabled.

0 updates can be applied immediately.

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


The list of available updates is more than a week old.
To check for new updates run: sudo apt update


The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

azureuser@VM-Jack:~$
```
## III. Blob storage ##
### 2. Let's go ###
Extrait du storage.tf

```tf
resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "main" {
  name                  = var.storage_container_name
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}

data "azurerm_virtual_machine" "main" {
  name                = azurerm_linux_virtual_machine.main.name
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_role_assignment" "vm_blob_access" {
  principal_id = data.azurerm_virtual_machine.main.identity[0].principal_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_storage_account.main.id

  depends_on = [
    azurerm_linux_virtual_machine.main
  ]
}
```

Extrait du main.tf
```tf
resource "azurerm_linux_virtual_machine" "main" {
  name                = "VM-Jack"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "vm-os-disk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  
  identity {
    type = "SystemAssigned"
  }
}
```
### 3. Proooooooofs ###
Installation azcopy
```shell
#suite de commandes :
cd /tmp
wget https://aka.ms/downloadazcopy-v10-linux -O azcopy.tar.gz
tar -xvf azcopy.tar.gz
sudo cp ./azcopy_linux_amd64_*/azcopy /usr/bin/
azcopy --version #pour vérifier l'installation
```
azcopy login
```shell
#commande :
azureuser@VM-Jack:/tmp$ azcopy login --identity
#résultat :
INFO: Login with identity succeeded.
```

Création d'un fichier sur la VM
```shell
#commande :
touch /home/azureuser/fichier.txt
```

Écriture d'un fichier dans le Storage Container
```shell
#commande :
azcopy copy '/home/azureuser/fichier.txt' \
"https://storageaccjacques.blob.core.windows.net/storagecontjacques/"

#résultat :
INFO: Scanning...
INFO: Autologin not specified.
INFO: Authenticating to destination using Azure AD
INFO: Any empty folders will not be processed, because source and/or destination doesn't have full folder support

Job 97a8b7dd-3b02-a242-44b7-2f53ff9ac643 has started
Log file is located at: /home/azureuser/.azcopy/97a8b7dd-3b02-a242-44b7-2f53ff9ac643.log

100.0 %, 1 Done, 0 Failed, 0 Pending, 0 Skipped, 1 Total,


Job 97a8b7dd-3b02-a242-44b7-2f53ff9ac643 summary
Elapsed Time (Minutes): 0.0335
Number of File Transfers: 1
Number of Folder Property Transfers: 0
Number of Symlink Transfers: 0
Total Number of Transfers: 1
Number of File Transfers Completed: 1
Number of Folder Transfers Completed: 0
Number of File Transfers Failed: 0
Number of Folder Transfers Failed: 0
Number of File Transfers Skipped: 0
Number of Folder Transfers Skipped: 0
Number of Symbolic Links Skipped: 0
Number of Hardlinks Converted: 0
Number of Special Files Skipped: 0
Total Number of Bytes Transferred: 0
Final Job Status: Completed

azureuser@VM-Jack:~$
```
Lecture d'un fichier dans le Storage Container
```shell
#commande :
azcopy copy "https://storageaccjacques.blob.core.windows.net/storagecontjacques/fichier.txt" ./localfile.txt && cat ./localfile.txt

#résultat :
INFO: Scanning...
INFO: Autologin not specified.
INFO: Authenticating to source using Azure AD
INFO: Any empty folders will not be processed, because source and/or destination doesn't have full folder support

Job 52861fbb-18ce-5e40-4eff-3ef0858a2c7c has started
Log file is located at: /root/.azcopy/52861fbb-18ce-5e40-4eff-3ef0858a2c7c.log

100.0 %, 1 Done, 0 Failed, 0 Pending, 0 Skipped, 1 Total, 2-sec Throughput (Mb/s): 0


Job 52861fbb-18ce-5e40-4eff-3ef0858a2c7c summary
Elapsed Time (Minutes): 0.0334
Number of File Transfers: 1
Number of Folder Property Transfers: 0
Number of Symlink Transfers: 0
Total Number of Transfers: 1
Number of File Transfers Completed: 1
Number of Folder Transfers Completed: 0
Number of File Transfers Failed: 0
Number of Folder Transfers Failed: 0
Number of File Transfers Skipped: 0
Number of Folder Transfers Skipped: 0
Number of Symbolic Links Skipped: 0
Number of Hardlinks Converted: 0
Number of Special Files Skipped: 0
Total Number of Bytes Transferred: 5
Final Job Status: Completed

test

```
Explication azcopy login

En ajoutant dans le main.tf l'identity (system assigned) cela permet à Azure de lui attribuer une managed identity (compte spécial créé par azure pour une ressource) 

Lors de la commande azcopy login --identity  
En premier, Azcopy détecte que la VM possède une managed identity  
Ensuite Azcopy contacte le service d’identité local de la VM (IMDS) et demande un token d'authentification pour azure storage.  
Azcopy récupèrele token localement et l'utilise pour toutes les commandes suivantes sans avoir besoin de mdp.


Requête d'un JWT d'authentification
```powershell
#commande :
 curl -H "Metadata:true" \
  "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://storage.azure.com/"

#résultat :
{"access_token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IkpZaEFjVFBNWl9MWDZEQmxPV1E3SG4wTmVYRSIsImtpZCI6IkpZaEFjVFBNWl9MWDZEQmxPV1E3SG4wTmVYRSJ9.eyJhdWQiOiJodHRwczovL3N0b3JhZ2UuYXp1cmUuY29tLyIsImlzcyI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzQxMzYwMGNmLWJkNGUtNGM3Yy04YTYxLTY5ZTczY2RkZjczMS8iLCJpYXQiOjE3NTcxNTMwMzcsIm5iZiI6MTc1NzE1MzAzNywiZXhwIjoxNzU3MjM5NzM3LCJhaW8iOiJrMlJnWURBdFdMODlWTVp1NDdXME9mV1ZpbjdSQUE9PSIsImFwcGlkIjoiOTJjODBlZDctMTYxZi00OGZkLTlkYTQtNmIwMzNhNGE4ODI5IiwiYXBwaWRhY3IiOiIyIiwiaWRwIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvNDEzNjAwY2YtYmQ0ZS00YzdjLThhNjEtNjllNzNjZGRmNzMxLyIsImlkdHlwIjoiYXBwIiwib2lkIjoiMTE4YTAwNjctNWQ3Zi00ZDhkLTk0ZWItMzZmOTJlZjE4ZjEzIiwicmgiOiIxLkFUc0F6d0EyUVU2OWZFeUtZV25uUE4zM01ZR21CdVRVODZoQ2tMYkNzQ2xKZXZFVkFRQTdBQS4iLCJzdWIiOiIxMThhMDA2Ny01ZDdmLTRkOGQtOTRlYi0zNmY5MmVmMThmMTMiLCJ0aWQiOiI0MTM2MDBjZi1iZDRlLTRjN2MtOGE2MS02OWU3M2NkZGY3MzEiLCJ1dGkiOiJvNTlVRkhVQzlrZXFIb1NqSUllZkFnIiwidmVyIjoiMS4wIiwieG1zX2Z0ZCI6ImRzQ0M1cUZXQUQwSzJHckRmdjI4RjdfbGQ2SkRpc1BsOV9iQ2h4c0hoRUlCZFd0emIzVjBhQzFrYzIxeiIsInhtc19pZHJlbCI6IjcgMzAiLCJ4bXNfbWlyaWQiOiIvc3Vic2NyaXB0aW9ucy83MTMzMjA4OS05NjFkLTQ2NTEtYjNmZi1iNzQ4Y2QyY2QxMzQvcmVzb3VyY2Vncm91cHMvR1AtSmFjcXVlcy9wcm92aWRlcnMvTWljcm9zb2Z0LkNvbXB1dGUvdmlydHVhbE1hY2hpbmVzL1ZNLUphY2siLCJ4bXNfcmQiOiIwLjQyTGxZQkppdEJZUzRlQVVFbERwOWJWYnVlMjI3NlF2NmJveW1rMTZRRkVPSVlIR1pXeFBybnhlNFRSaDI2RU5tcDVWSHdFIiwieG1zX3RkYnIiOiJFVSJ9.cIDQV4y13AVAjiruIAcUAbANuVybFfizHXSS4-WBSv5L-CWOmTyE_88BKd0GwkXMTqHCKX8akHOQBrZcxSWJ3xqeiYhvWtOJHZPSBHi-OeTIvLlfz-ZsdVTFnfZYP985_4G9fW-qRXKHGes4NFXFs4PoTp99ZwLknklKjYpwE-IX6sWJJYW0zu2KYJ0wV1tKvt2aJ_OweeKYOuNhORBD9yRPAh8nt7sDWncy5nz1TnlvG98BCzKxNaAxrCHhpsz_w48BteP2PfpRfiB0i1bYsSKg55n20prp6ByV4WpKrvvPojDo0ljvZhIlHGi27dLcYdAt2z1ptJxFAkafHSFWEg","client_id":"92c80ed7-161f-48fd-9da4-6b033a4a8829","expires_in":"86400","expires_on":"1757239737","ext_expires_in":"86399","not_before":"1757153037","resource":"https://storage.azure.com/","token_type":"Bearer"}
```

Explication de l'IP joignable
```shell
ip route show
default via 10.0.1.1 dev eth0 proto dhcp src 10.0.1.4 metric 100
10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp src 10.0.1.4 metric 100
169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp src 10.0.1.4 metric 100
```
L’adresse 169.254.169.254 est une addresse link-local qui n'est pas routable sur internet.  
Sur Azure, cette adresse est utilisée pour exposer des services metadata et managed identity aux VM sans que l'adresse ne soit exposée à un autre appareil que la VM elle même.

## IV. Monitoring ##
### 2. Une alerte CPU ###

Extrait CPU du monitoring.tf
```tf
resource "azurerm_monitor_action_group" "main" {
  name                = "ag-${var.resource_group_name}-alerts"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "vm-alerts"

  email_receiver {
    name          = "admin"
    email_address = var.alert_email_address
  }
}

# CPU Metric Alert (using platform metrics)
resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "cpu-alert-${azurerm_linux_virtual_machine.main.name}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_virtual_machine.main.id]
  description         = "Alert when CPU usage exceeds 70%"
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 70
  }

  window_size   = "PT5M"
  frequency     = "PT1M"
  auto_mitigate = true

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
```

### 3. Alerte mémoire ###

Extrait RAM du monitoring.tf
```tf
resource "azurerm_monitor_metric_alert" "memory_alert" {
  name                = "memory-alert-${azurerm_linux_virtual_machine.main.name}"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_linux_virtual_machine.main.id]
  description         = "Alert when available memory is low"
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Available Memory Bytes"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 536870912
  }

  window_size   = "PT5M"
  frequency     = "PT1M"
  auto_mitigate = true

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
```

### 4. Proofs ###

Commande AZ show monitoring

```shell
#commande :
az monitor metrics alert list --resource-group GP-Jacques
#résultat :
[
  {
    "actions": [
      {
        "actionGroupId": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Insights/actionGroups/ag-GP-Jacques-alerts",
        "webHookProperties": {}
      }
    ],
    "autoMitigate": true,
    "criteria": {
      "allOf": [
        {
          "criterionType": "StaticThresholdCriterion",
          "metricName": "Percentage CPU",
          "metricNamespace": "Microsoft.Compute/virtualMachines",
          "name": "Metric1",
          "operator": "GreaterThan",
          "skipMetricValidation": false,
          "threshold": 70.0,
          "timeAggregation": "Average"
        }
      ],
      "odata.type": "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria"
    },
    "description": "Alert when CPU usage exceeds 70%",
    "enabled": true,
    "evaluationFrequency": "PT1M",
    "id": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Insights/metricAlerts/cpu-alert-VM-Jack",
    "location": "global",
    "name": "cpu-alert-VM-Jack",
    "resourceGroup": "GP-Jacques",
    "scopes": [
      "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Compute/virtualMachines/VM-Jack"
    ],
    "severity": 2,
    "tags": {},
    "targetResourceRegion": "",
    "targetResourceType": "",
    "type": "Microsoft.Insights/metricAlerts",
    "windowSize": "PT5M"
  },
  {
    "actions": [
      {
        "actionGroupId": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Insights/actionGroups/ag-GP-Jacques-alerts",
        "webHookProperties": {}
      }
    ],
    "autoMitigate": true,
    "criteria": {
      "allOf": [
        {
          "criterionType": "StaticThresholdCriterion",
          "metricName": "Available Memory Bytes",
          "metricNamespace": "Microsoft.Compute/virtualMachines",
          "name": "Metric1",
          "operator": "LessThan",
          "skipMetricValidation": false,
          "threshold": 536870912.0,
          "timeAggregation": "Average"
        }
      ],
      "odata.type": "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria"
    },
    "description": "Alert when available memory is low",
    "enabled": true,
    "evaluationFrequency": "PT1M",
    "id": "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Insights/metricAlerts/memory-alert-VM-Jack",
    "location": "global",
    "name": "memory-alert-VM-Jack",
    "resourceGroup": "GP-Jacques",
    "scopes": [
      "/subscriptions/************************************/resourceGroups/GP-Jacques/providers/Microsoft.Compute/virtualMachines/VM-Jack"
    ],
    "severity": 2,
    "tags": {},
    "targetResourceRegion": "",
    "targetResourceType": "",
    "type": "Microsoft.Insights/metricAlerts",
    "windowSize": "PT5M"
  }
]
```

Stress pour fire les alertes :

Installation
```shell
#commande :
sudo apt update
sudo apt install stress-ng -y
```
Stress CPU
```shell
#commande :
stress-ng --cpu 0 --timeout 300s
#résultat :
stress-ng: info:  [14484] dispatching hogs: 1 cpu
stress-ng: info:  [14484] successful run completed in 300.15s (5 mins, 0.15 secs)
```

Stress RAM
```shell
#commande :
stress-ng --vm 2 --vm-bytes 512M --timeout 300s

#résultat :
stress-ng: info:  [14499] dispatching hogs: 2 vm
stress-ng: info:  [14499] successful run completed in 300.00s (5 mins, 0.00 secs)
```

Vérification de l'activation des alertes et leurs résolutions
```shell
#commande :
az monitor activity-log list `
    --resource-group GP-Jacques `
    --offset 1h `
    --query "[?category.value=='Administrative' && contains(operationName.value, 'alert')].{Time:eventTimestamp, AlertName:operationName.value, Status:status.value}" `
    --output table

#résultat :
Time                          AlertName                              Status
----------------------------  -------------------------------------  ---------
2025-09-06T13:17:12.2852531Z  Microsoft.Insights/metricalerts/write  Succeeded
2025-09-06T13:17:11.1172946Z  Microsoft.Insights/metricalerts/write  Succeeded
```
## V. Azure Vault ##
### 2. Do it ! ###
Extrait keyvault.tf

```tf
resource "azurerm_key_vault" "main" {
  name                       = var.vault_name
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    secret_permissions = [
      "Get", "List", "Set", "Delete", "Purge", "Recover"
    ]
  }

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_linux_virtual_machine.main.identity[0].principal_id
    secret_permissions = [
      "Get", "List"
    ]
  }
}

resource "random_password" "jacques_secret" {
  length           = 16
  special          = true
  override_special = "@#$%^&*()"
}

resource "azurerm_key_vault_secret" "jacques_secret" {
  name         = "SecretJacques"
  value        = random_password.jacques_secret.result
  key_vault_id = azurerm_key_vault.main.id
}
```

Extrait du outputs.tf
```tf
output "secret" {
  description = "Valeur secret"
  value       = random_password.jacques_secret.result
  sensitive   = true
}
```
### 3. Proof proof proof ###

Affichage du secret :

Avec az
```powershell
#commande :
az keyvault secret show --name "SecretJacques" --vault-name "vaultjacques"

#résultat :
{
  "attributes": {
    "created": "2025-09-07T06:57:04+00:00",
    "enabled": true,
    "expires": null,
    "notBefore": null,
    "recoverableDays": 7,
    "recoveryLevel": "CustomizedRecoverable+Purgeable",
    "updated": "2025-09-07T06:57:04+00:00"
  },
  "contentType": "",
  "id": "https://vaultjacques.vault.azure.net/secrets/SecretJacques/35e9fe713b444bd2aa2a1061432129a2",
  "kid": null,
  "managed": null,
  "name": "SecretJacques",
  "tags": {},
  "value": "0)goEZ)UfUS@dWQ$"
}
```

Depuis la VM

Création d'un script :
```shell
touch scriptsecret.sh
chmod +x scriptsecret.sh
nano scriptsecret.sh
```
Contenu du script
```shell
#!/bin/bash

#Installation de jq pour parser le JSON
sudo apt-get update
sudo apt-get install -y jq

# Variables
KEYVAULT_NAME="vaultjacques"
SECRET_NAME="SecretJacques"

# Récupérer un token d’accès avec l’identity managée de la VM
ACCESS_TOKEN=$(sudo curl -s \
  -H "Metadata: true" \
  "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net" \
  | jq -r '.access_token')

# Récupérer le secret depuis le Key Vault
SECRET_VALUE=$(sudo curl -s \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  "https://${KEYVAULT_NAME}.vault.azure.net/secrets/${SECRET_NAME}?api-version=7.4" \
  | jq -r '.value')

echo "Valeur du secret : $SECRET_VALUE"
```


Exécution du script
```shell
#commande :
azureuser@VM-Jack:~$ ./scriptsecret.sh

#résultat :
Hit:1 http://azure.archive.ubuntu.com/ubuntu focal InRelease
Hit:2 http://azure.archive.ubuntu.com/ubuntu focal-updates InRelease
Hit:3 http://azure.archive.ubuntu.com/ubuntu focal-backports InRelease
Hit:4 http://azure.archive.ubuntu.com/ubuntu focal-security InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree
Reading state information... Done
jq is already the newest version (1.6-1ubuntu0.20.04.1).
0 upgraded, 0 newly installed, 0 to remove and 41 not upgraded.
Valeur du secret : 0)goEZ)UfUS@dWQ$
```

![Alt Text](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNjkyOGN4M2UxdG41bjZtZWh4MnIwNGxubGl3eGQ4azd5NTdmNmcyaCZlcD12MV9naWZzX3NlYXJjaCZjdD1n/3oz8xIsloV7zOmt81G/giphy.gif)
